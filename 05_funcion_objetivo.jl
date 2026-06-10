
"funcion a optimizarr"
function funcion_objetivo!(model, N,Q,origen,horario_salida,W,retraso,A, D,z, ZSet, U, beta;
    a_1 = 1.0,
    a_2 = 1.0,
    a_3 = 1.0
)

    @constraint(model,
        [i in N],
        retraso[i] >= D[i, origen[i]] - horario_salida[i]
    )
    
    costo_infraestructura = beta*sum( U[c]*z[(q,c)]  for (q,c) in ZSet)

    costo_retraso =
        sum(W[i] * retraso[i] for i in N)

    costo_espera =
        sum(W[i] * (D[i,q] - A[i,q]) for i in N, q in Q)

    @objective(
        model,
        Min,
        a_1*costo_retraso +
        a_2*costo_espera +
        a_2*costo_infraestructura
    )

end
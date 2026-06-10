" restriccionde salida para cada tren"
function ventana_salida!(model, N, origen, horario_salida, D,tolerancia)

    @constraint( model, [i in N],D[i,origen[i]] >= horario_salida[i] )

    @constraint( model, [i in N], D[i,origen[i]] <= horario_salida[i] + tolerancia )

end

" restriccion de llegada  para cada tren"
function ventana_llegada_pasajeros!(model, N_pasajeros, K, lambda_min, lambda_max, A)

    @constraint( model, [i in N_pasajeros, q in K], A[i,q] >= lambda_min[q] )

    @constraint( model,[i in N_pasajeros, q in K], A[i,q] <= lambda_max[q] )

end

" restriccion de version simple  para cada tren"
function ventana_llegada_pasajeros_1!(model, N_pasajeros, destino, lambda_min, lambda_max, A)

    @constraint( model, [i in N_pasajeros], A[i,destino[i]] >= lambda_min[destino[i]] )

    @constraint( model,[i in N_pasajeros], A[i,destino[i]] <= lambda_max[destino[i]] )

end
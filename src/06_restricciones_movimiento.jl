"tiempo de llegada entre nodos"
function movimiento_dp!( model,N, P,direccion,A, D, d, velocidad)

    for i in N

        for p in P

            q = nodo_salida( p, direccion[i] )

            s = nodo_llegada( p, direccion[i] )

            @constraint( model, A[i,s] - D[i,q] == 60*d[p] / velocidad[i] )

        end

    end

end

"restriccion no se puede llegar abtes de salir"
function restriccion_llegada_salida!( model,  N, Q, A,D)

    @constraint( model, [i in N, q in Q], D[i,q] >= A[i,q] )

end

"Activacion meet/pass"

function restriccion_activacion_meet_pass!(model, N,Q, M,tau, A,D, o)

    @constraint(model, [i in N, q in Q] , M * o[i,q] >=  D[i,q] - A[i,q] - tau[(i,q)] )

end

"restriccion de tiempo min en ladero"
function restriccion_tiempo_ladero!(model, N, Q,tau,f, t_ladero, varsigma,A, D, o)

    @constraint( model, [i in N, q in Q], D[i,q] >= A[i,q] + o[i,q] *(f[i]+ t_ladero[(i,q)] + varsigma ) + tau[(i,q)] )

end

"restriccion de tiempo max en ladero para los de carga"
function espera_maxima_ladero!(model, N_carga, Q, A, D, tau, o, M, t_max_ladero)

    @constraint(model,[i in N_carga, q in Q], D[i,q] - A[i,q] - tau[(i,q)]

        <= t_max_ladero + M*(1-o[i,q]))

end
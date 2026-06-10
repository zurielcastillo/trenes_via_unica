"longitud total de los segmentos debe coincidir con toda la linea"
function longitud_total_linea!(model,P,d,L_total)

    @constraint(model, sum(d[p] for p in P)== L_total)

end


"una zona por ladero"
function una_zona_por_ladero!(model, Qc,C, z)

    @constraint(model, [q in Qc], sum(z[(q,c)] for c in C) <= 1)

end

"si un ladero existe fuerza a z"
function laderos_existentes!(model, Q_existentes, C, z)

    @constraint(model, [q in Q_existentes], sum(z[(q,c)] for c in C) == 1 )

end

function activacion_ladero!( model, N, Q, C, M, o, z)

    @constraint( model, [q in Kappa], sum(o[i,q] for i in N) <= M *sum(z[(q,c)] for c in C))

end

"restriccion de los presupuestos"
function presupuesto!(model,Qc, C,U,z,B)

    @constraint(model,sum( U[c] * z[(q,c)] for q in Qc, c in C ) <= B )

end


function zonas_construccion!(model, Kappa, C,sigma, M, d,z)

    for q in Kappa

        p = q - 1

        for c in C

            @constraint( model, sum(d[r] for r in 1:p) >=
            sigma[c] - M * (1 - z[(q,c)]))

            @constraint( model, sum(d[r] for r in 1:p)<= 
            sigma[c+1] +M * (1 - z[(q,c)]))

        end

    end

end
"separacion minima ente laderos candidatos"
function separacion_minima!( model, Qc, C, d,z, g,M)

    for q in Qc

        p = q - 1

        @constraint( model, d[p] >= g - M * ( 1 -sum(z[(q,c)] for c in C)))

    end

end



# ECUACIÓN (18)
"FIJA LA POSICIÓN DE NODOS EXISTENTES" 
function nodos_existentes!( model,Qe, d, phi)

    for q in Qe

        # El primer nodo normalmente está en el origen
        if q > 1

            @constraint( model, sum(d[r] for r in 1:(q-1)) == phi[q] )

        end

    end

end


"Limite de horarios de llegada"
function horizonte_tiempo!( model, N,destino, A, E)

    @constraint( model, [i in N],A[i,destino[i]] <= E )

end


"funcion que  da los pares de trenes con sentido igual (b_plus) y opuesto (b_minus) "
function pares_mis_op_sentido(N)

    b_plus = Tuple{Int,Int}[]
    b_minus = Tuple{Int,Int}[]

    for i in N, j in N

        if i < j

            if direccion[i] == direccion[j]

                push!(b_plus, (i,j))

            else

                push!(b_minus, (i,j))

            end

        end

    end

    return b_plus, b_minus

end
 

" Nodos y segmentos visitados por cada tren"     
function  visitados_Q_P(Q,P)    
    Q_i = Dict()
    P_i = Dict()
    for i in N

        Q_i[i] = copy(Q)
        P_i[i] = copy(P)

    end
    return Q_i, P_i    
end
        
function conjunto_zonas()

    return [1,2,3]

    # 1 Rural
    # 2 Urbana
    # 3 Montaña

end
        
function conjunto_Omega(b_plus,b_minus,P_i)

    Omega = Tuple{Int,Int,Int}[]

    for (i,j) in vcat(b_plus,b_minus)

        segmentos_comunes =
            intersect(P_i[i],P_i[j])

        for p in segmentos_comunes

            push!(Omega,(i,j,p))

        end

    end

    return Omega

end
        
        
function Conjunto_Theta(b_plus,b_minus,Q)        
      ThetaSet = Set{Tuple{Int,Int,Int}}()

for (i,j) in vcat(b_plus,b_minus)
    for q in Q
        push!(ThetaSet,(i,j,q))
    end
end

ThetaSet = collect(ThetaSet)
                return ThetaSet
end
            
            
function conjunto_zonas(n_zonas)

    return collect(1:n_zonas)

end 
            
function conjunto_kappa(Q_existentes,Qc)

    return union(Q_existentes,Qc)

end
            
function conjunto_Z(Q,C)

    return [(q,c) for q in Q for c in C]

end
            
            
function sigma_zonas(C, L_total)

    sigma = Dict()

    paso = L_total / length(C)

    sigma[1] = 0.0

    for c in 2:length(C)+1
        sigma[c] = sigma[c-1] + paso
    end

    return sigma

end
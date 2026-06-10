"ecuacion 11"
function restriccion_theta_1!( model, ThetaSet,P, o,x, theta)

    for (i,j,q) in ThetaSet

        for p in P

            if q in delta_p(p)

                @constraint(model, theta[(i,j,q)] >= o[i,q] + o[j,q] + x[(i,j,p)] -2 )

            end

        end

    end

end

"ecuacion 12"
function restriccion_theta_2!( model, ThetaSet,  P, o, x, theta)

    for (i,j,q) in ThetaSet

        for p in P

            if q in delta_p(p)

                @constraint( model, 3*theta[(i,j,q)] <= o[i,q]  + o[j,q]  + x[(i,j,p)])

            end

        end

    end

end

"ecuacion 13"
function capacidad_ladero!( model, ThetaSet, P,M, varsigma,headway, A,  D, theta)

    for (i,j,q) in ThetaSet

        for p in P

            if q in delta_p(p)

                @constraint( model, A[j,q] >= D[i,q] + varsigma +  headway[(i,j,p)] - M*(1-theta[(i,j,q)]) )

            end

        end

    end

end


# ==========================================================
# (14) Restricción de longitud de ladero
#
# o[i,q] <= L[i,q]
#
# No se implementa porque:
# L[i,q] = 1 para todos los trenes y nodos.
# Todos los trenes caben en todos los laderos.
# ==========================================================
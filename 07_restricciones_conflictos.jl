
"restricciones de adelantamiento mismo sentido (salidas)"

function conflicto_mismo_sentido_salida_1!(model,  b_plus,   P, direccion, M, headway, varsigma, D, o,x)

    for (i,j) in b_plus

        for p in P

            q = nodo_salida(p,direccion[i])

            @constraint( model,M*(1 - x[(i,j,p)]) + D[j,q] 
                >= D[i,q] +  headway[(i,j,p)] + varsigma*o[i,q] )

        end

    end

end



"restricciones de adelantamiento mismo sentido (llegadas)"
function conflicto_mismo_sentido_llegada_1!( model,  b_plus,  P, direccion, M,headway, varsigma, A, o, x)

    for (i,j) in b_plus

        for p in P

            q = nodo_llegada(p,direccion[i])

            @constraint(model, M*(1 - x[(i,j,p)]) +  A[j,q]
                 >= A[i,q] +  headway[(i,j,p)] + varsigma*o[i,q] )

        end

    end

end

"restricciones de adelantamiento sentidos opuestos"
function conflicto_opuesto_1!( model, b_minus,P, direccion, M, headway, varsigma, A, D, x)

    for (i,j) in b_minus

        for p in P

            qs_j = nodo_salida(p,direccion[j])

            ql_i = nodo_llegada(p,direccion[i])

            @constraint( model, M*(1 - x[(i,j,p)]) +  D[j,qs_j]  >= A[i,ql_i] + headway[(i,j,p)] + varsigma )

        end

    end

end


"espejo de las otras tres anteriores"

function conflicto_mismo_sentido_salida_2!( model, b_plus, P, direccion, M, headway,varsigma,  D, o, x)

    for (i,j) in b_plus

        for p in P

            q = nodo_salida(p,direccion[i])

            @constraint( model,  M*x[(i,j,p)] +  D[i,q]

                >= D[j,q] + headway[(i,j,p)]  + varsigma*o[i,q] )

        end

    end

end

function conflicto_mismo_sentido_llegada_2!( model, b_plus, P, direccion,  M, headway, varsigma, A, o,x)

    for (i,j) in b_plus

        for p in P

            q = nodo_llegada(p,direccion[i])

            @constraint( model, M*x[(i,j,p)] + A[i,q]

                >= A[j,q] + headway[(i,j,p)] + varsigma*o[i,q] )

        end

    end

end

function conflicto_opuesto_2!( model, b_minus,  P, direccion,  M,  headway, varsigma, A, D, x)

    for (i,j) in b_minus

        for p in P

            qs_i = nodo_salida(p,direccion[i])

            ql_j = nodo_llegada(p,direccion[j])

            @constraint( model, M*x[(i,j,p)] + D[i,qs_i] >=  A[j,ql_j]  +  headway[(i,j,p)] + varsigma )

        end

    end

end
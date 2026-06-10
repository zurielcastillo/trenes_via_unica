

function nodo_salida(p, sentido)

    if sentido == 1
        return p
    else
        return p + 1
    end

end


function nodo_llegada(p, sentido)

    if sentido == 1
        return p + 1
    else
        return p
    end

end

function delta_p(p)
    return (p, p+1)
end

function construir_lambdas(Q, phi, velocidad_pasajeros, tolerancia)

    lambda_prog = Dict()
    lambda_min  = Dict()
    lambda_max  = Dict()

    for q in Q

        tiempo_ideal = phi[q] / velocidad_pasajeros * 60

        lambda_prog[q] = tiempo_ideal

        lambda_min[q] =
            tiempo_ideal - tolerancia

        lambda_max[q] =
            tiempo_ideal + tolerancia

    end

    return lambda_prog,
           lambda_min,
           lambda_max

end

# ==========================================================
# HEADWAY
# ==========================================================
function headways(N, P, tipo;h_pasajero=5.0,h_mixto=10.0,h_carga=15.0)

    headway = Dict{Tuple{Int,Int,Int},Float64}()

    for i in N, j in N, p in P

        if tipo[i] == 1 && tipo[j] == 1

            headway[(i,j,p)] = h_pasajero

        elseif tipo[i] == 0 && tipo[j] == 0

            headway[(i,j,p)] = h_carga

        else

            headway[(i,j,p)] = h_mixto

        end

    end

    return headway

end

"velocidad dependiendo tipo de tren"
function v_trenes(N,tipo;v_carga= 50.0,v_pasajeros = 70.0)
    velocidad = Dict()

    for i in N
        if tipo[i] == 1
        velocidad[i] = v_pasajeros
        else
        velocidad[i] = v_carga
        end
    end
    return velocidad
end

"segementos aleatorios la usma es la longitud total"
function generar_longitudes(P, longitud_total)

    pesos = rand(length(P))

    pesos ./= sum(pesos)

    longitud_segmento = Dict{Int,Float64}()

    for (k,p) in enumerate(P)
        longitud_segmento[p] = pesos[k] * longitud_total
    end

    return longitud_segmento

end


"tiempo del segmento"
function tiempo_segemento(N,P,longitud_segmento, velocidad)
    tiempo_segmento = Dict{Tuple{Int,Int},Float64}()

    for i in N, p in P

        tiempo_segmento[(i,p)] =
        60 * longitud_segmento[p] / velocidad[i]

    end
    return tiempo_segmento
    
end

"genera tau paradas obligatorias en nodos que existen obligatoriamente"
function generar_tau(N,Q,Qe,tipo_tren)

    tau = Dict{Tuple{Int,Int},Float64}()

    for i in N, q in Q

        if tipo_tren[i] == 1   # pasajero

            tau[(i,q)] = q in Qe ? 2.0 : 1.0

        else                   # carga

            tau[(i,q)] = 0.0

        end

    end

    return tau

end




"perdida de tiempo frenando"
function generar_f(N, tipo_tren;f_pasajero = 2.0, f_carga = 5.0)

    f = Dict{Int,Float64}()

    for i in N

        if tipo_tren[i] == 1
            f[i] = f_pasajero
        else
            f[i] = f_carga
        end

    end

    return f

end

" tiempo de maniobra para entrar en laderro"
function generar_t_ladero(N,Q; t_default=0.0)

    t_ladero = Dict{Tuple{Int,Int},Float64}()

    for i in N, q in Q
        t_ladero[(i,q)] = t_default
    end

    return t_ladero

end

"Variable de compatibilkidad con ladero, 1 si todos los trenes caben en ladero q"
function generar_L(N,Q; L_default = 1)

    L = Dict{Tuple{Int,Int},Int}()

    for i in N, q in Q
        L[(i,q)] = L_default
    end

    return L

end

"genera costos de laderos dependiendo la zona que se construye"
function generar_costos_ladero(Qc, zona;
                               costo_rural = 100.0,
                               costo_urbano = 300.0,
                               costo_montana = 500.0)

    costo_ladero = Dict{Int,Float64}()

    for q in Qc

        if zona[q] == 1

            costo_ladero[q] = costo_rural

        elseif zona[q] == 2

            costo_ladero[q] = costo_urbano

        elseif zona[q] == 3

            costo_ladero[q] = costo_montana

        else

            error("Zona no válida para nodo $q")

        end

    end

    return costo_ladero

end


"genera zonas aleatorias para los nodos (adaptar para el caso de cada estudio)"
function generar_zonas(Qc;
                       p_rural = 0.6,
                       p_urbana = 0.3,
                       p_montana = 0.1)

    zonas = Dict{Int,Int}()

    for q in Qc

        r = rand()

        if r <= p_rural

            zonas[q] = 1

        elseif r <= p_rural + p_urbana

            zonas[q] = 2

        else

            zonas[q] = 3

        end

    end

    return zonas

end


"peso por retraso de cada tren "
function generar_pesos(N, tipo_tren;
                       W_pasajero = 10.0,
                       W_carga = 1.0)

    W = Dict{Int,Float64}()

    for i in N

        if tipo_tren[i] == 1
            W[i] = W_pasajero
        else
            W[i] = W_carga
        end

    end

    return W

end

"generacion de horarios e salida"
function generar_horario_salida(N, direccion;
                                intervalo = 15.0)

    horario = Dict{Int,Float64}()

    trenes_ida = sort([i for i in N if direccion[i] == 1])
    trenes_vuelta = sort([i for i in N if direccion[i] == -1])

    for (k,i) in enumerate(trenes_ida)
        horario[i] = (k-1)*intervalo
    end

    for (k,i) in enumerate(trenes_vuelta)
        horario[i] = (k-1)*intervalo
    end

    return horario

end

#refinar
"Costo de zonas "
function costo_zonas(C;alpha = 5)

    U = Dict()

    for c in C

        U[c] = alpha*c

    end

    return U

end
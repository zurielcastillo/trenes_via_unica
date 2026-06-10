# ==========================================================
# CONFIGURACIÓN GENERAL
# ==========================================================


function crear_instancias(n_trenes,n_nodos)

    #Nodos
    Q = collect(1:n_nodos)
    #nodos siempre existentes (terminales)
    Qe = [first(Q), last(Q)]
    #laderos candidatos  
    Qc = setdiff(Q,Qe)
    #segementos entre nodos
    P = collect(1:(n_nodos-1))
        
    # trenes
    N = collect(1:n_trenes)

    return Q,Qe,Qc,P,N
end


function crear_diecciones(N,n_trenes)
    #direcciones de tenes
    direccion = Dict()

    for i in N

        if i <= n_trenes ÷ 2
            direccion[i] = 1
        else
            direccion[i] = -1
        end
    end
    return direccion
end


function crear_origen_destino(N,Q,direccion)

    #origen y destino por cada tren

    origen = Dict()
    destino = Dict()

    for i in N

        if direccion[i] == 1

            origen[i] = first(Q)
            destino[i] = last(Q)

        else

            origen[i] = last(Q)
            destino[i] = first(Q)

        end

    end
    return origen, destino 
end

using Random

"genera diccionario con tipo de trenes de carga 0 y pasajeros 1"
function generar_tipos_tren(N, n_pasajeros)

    n_trenes = length(N)

    tipo = Dict(i => 0 for i in N)

    idx_pasajeros = randperm(n_trenes)[1:n_pasajeros]

    for i in idx_pasajeros
        tipo[i] = 1
    end

    return tipo

end
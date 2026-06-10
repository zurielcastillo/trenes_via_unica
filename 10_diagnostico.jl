function imprimir_laderos_construidos(Q, C, z, d)

    println("\n==============================")
    println("LADEROS CONSTRUIDOS")
    println("==============================")

    for q in Q

        for c in C

            if JuMP.value(z[(q,c)]) > 0.5

                km = q == 1 ? 0.0 :
                    sum(JuMP.value(d[p]) for p in 1:(q-1))

                println(
                    "Nodo ", q,
                    " | Zona ", c,
                    " | km = ", round(km, digits=2)
                )

            end

        end

    end

end


function imprimir_segmentos(P, d)

    println("\n==============================")
    println("LONGITUD DE SEGMENTOS")
    println("==============================")

    for p in P

        println(
            "Segmento ",
            p,
            " = ",
            round(JuMP.value(d[p]), digits=2),
            " km"
        )

    end

end

function imprimir_nodos(Q, d)

    println("\n==============================")
    println("UBICACIÓN DE NODOS")
    println("==============================")

    for q in Q

        km = q == 1 ? 0.0 :
            sum(JuMP.value(d[p]) for p in 1:(q-1))

        println(
            "Nodo ",
            q,
            " -> ",
            round(km, digits=2),
            " km"
        )

    end

end


using Plots


function plot_trenes_km(
    N,
    Q,
    A,
    D,
    d,
    direccion
)

    # ---------------------------------
    # Posición física de cada nodo
    # ---------------------------------

    km_nodo = Dict{Int,Float64}()

    km_nodo[1] = 0.0

    for q in Q[2:end]

        km_nodo[q] =
            sum(
                JuMP.value(d[p])
                for p in 1:(q-1)
            )

    end

    plt = plot(
        xlabel = "Tiempo (min)",
        ylabel = "Posición (km)",
        legend = :topright,
        lw = 2
    )

    # ---------------------------------
    # Graficar cada tren
    # ---------------------------------

    for i in N

        tiempos = Float64[]
        posiciones = Float64[]

        if direccion[i] == 1

            recorrido = Q

        else

            recorrido = reverse(Q)

        end

        for q in recorrido

            push!(tiempos, JuMP.value(A[i,q]))
            push!(posiciones, km_nodo[q])

            push!(tiempos, JuMP.value(D[i,q]))
            push!(posiciones, km_nodo[q])

        end

        plot!(
            plt,
            tiempos,
            posiciones,
            marker = :circle,
            label = "Tren $i"
        )

    end

    display(plt)

end
    

function plot_trenes_nodos(
    N,
    Q,
    A,
    D,
    direccion
)

    plt = plot(
        xlabel = "Tiempo (min)",
        ylabel = "Nodo",
        legend = :topright,
        lw = 2
    )

    yticks!(
        collect(Q),
        ["Nodo $q" for q in Q]
    )

    for i in N

        tiempos = Float64[]
        nodos   = Float64[]

        recorrido =
            direccion[i] == 1 ?
            Q :
            reverse(Q)

        for q in recorrido

            push!(tiempos, JuMP.value(A[i,q]))
            push!(nodos, q)

            push!(tiempos, JuMP.value(D[i,q]))
            push!(nodos, q)

        end

        plot!(
            plt,
            tiempos,
            nodos,
            marker = :circle,
            label = "Tren $i"
        )

    end

    display(plt)

end

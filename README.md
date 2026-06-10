# Trenes Vía Única

## Descripción

Este repositorio contiene el desarrollo de un modelo de optimización para la programación de trenes en una línea ferroviaria de vía única utilizando Programación Lineal Entera Mixta (MILP, Mixed Integer Linear Programming).

El objetivo principal es generar horarios factibles para un conjunto de trenes que comparten infraestructura de vía única, considerando restricciones operativas como:

* Tiempos mínimos de recorrido entre estaciones.
* Cruces y adelantamientos en laderos.
* Separación temporal entre trenes.
* Conflictos por ocupación simultánea de segmentos de vía.
* Ventanas de salida y llegada programadas.
* Priorización de diferentes tipos de trenes.

## Base metodológica

La formulación implementada en este proyecto está inspirada principalmente en el artículo:

**A MILP Model for Train Scheduling on Single-Track Railways** (*milp_via_unica.pdf*),

del cual se toman como referencia los conceptos de:

* Representación de la infraestructura mediante segmentos y estaciones.
* Variables binarias de precedencia entre trenes.
* Restricciones de conflicto en segmentos compartidos.
* Restricciones de cruce en estaciones y laderos.
* Formulación MILP para garantizar factibilidad operacional.

La implementación actual adapta y extiende dichas ideas para experimentar con diferentes configuraciones operativas y escenarios de simulación.

## Estructura del proyecto

```text
src/            Código fuente en Julia
docs/           Documentación y referencias
```

## Tecnologías utilizadas

* Julia
* JuMP
* HiGHS / Gurobi (según disponibilidad)

## Estado del proyecto

Proyecto en desarrollo. La formulación y las restricciones continúan siendo refinadas y validadas mediante experimentos computacionales.

--
-- USO DE JOINS
--

-- EJERCICIO 1. PARA CADA DIA CONTENIDO EN LA TABLA DE KPI, 
--             ,OBTENER EN UNA TABLA EL TOTAL DE VISITAS
--             ,LOS GRPS EMITIDOS EN TV 
--             Y LOS GRPS EMITIDOS EN RADIO 
-- SUGERENCIA: USAR LA FUNCION DATE()

SELECT
    DATE("KPI"."Fecha_hora_minuto") AS DIA,
    SUM("KPI"."Visitas") AS TOT_VISITAS,
    SUM("TV"."Grps_ad16") AS TOT_GRPS_TV,
    SUM("Radio"."Grps_ad16") AS TOT_GRPS_RADIO
FROM
    "Marketing"."KPI"
    LEFT JOIN "Marketing"."TV" ON DATE("KPI"."Fecha_hora_minuto") = DATE("TV"."Fecha_hora_minuto")
    LEFT JOIN "Marketing"."Radio" ON DATE("KPI"."Fecha_hora_minuto") = DATE("Radio"."Fecha_hora_minuto")
GROUP BY
    DIA
ORDER BY
    DIA ASC;

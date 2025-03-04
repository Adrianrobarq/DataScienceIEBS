--Fases del proyecto

--Plantea las actividades a realizar en el proyecto en distintas fases para guiar a los alumnos paso a paso. Puedes dividirlo en las fases que creas necesarias.

--    Fase 1: Creación de una BBDD PostgreSQL y creación las tablas necesarias para almacenar la información.
--    Fase 2: Cargar dichas tablas con los datos que contiene cada fichero correspondiente.
--    Fase 3: Creación de una consulta que permita analizar el impacto de los anuncios de TV en los minutos posteriores a su emisión. 
--    Fase 4: Creación de una tabla con el resultado de la consulta y obtener un gráfico que permita visualizar la evolución de las visitas y los GRPs de los anuncios emitidos en TV. 
--    Fase adicional: Identificar qué anuncio de TV ha generado más visitas en la página web tras su emisión.

-- Creación de una consulta que permita analizar el impacto de los anuncios de TV en los minutos posteriores a su emisión.
WITH impacto AS(    
    SELECT 
        "TV"."Fecha_hora_minuto" as t_emision,      
        SUM("KPI"."Visitas") as tot_visitas,
        SUM("TV"."Grps_ad16") as GRP,
        SUM(CASE WHEN "KPI"."Fecha_hora_minuto" > "TV"."Fecha_hora_minuto" THEN "KPI"."Visitas" ELSE 0 END) -
        SUM(CASE WHEN "KPI"."Fecha_hora_minuto" < "TV"."Fecha_hora_minuto" THEN "KPI"."Visitas" ELSE 0 END) as dif_visitas
    FROM
        "Marketing"."TV"
    LEFT JOIN
        "Marketing"."KPI" ON "KPI"."Fecha_hora_minuto" BETWEEN "TV"."Fecha_hora_minuto"- INTERVAL '5 minutes' AND "TV"."Fecha_hora_minuto" + INTERVAL '5 minutes'
    GROUP BY t_emision)
SELECT
    t_emision,
    tot_visitas,
    GRP,
    dif_visitas
FROM
    impacto
ORDER BY
    t_emision;

-- Creación de una tabla con el resultado de la consulta y obtener un gráfico que permita visualizar la evolución de las visitas y los GRPs de los anuncios emitidos en TV.
CREATE TABLE IF NOT EXISTS "Marketing"."Impacto_TV" AS
    WITH impacto AS(    
        SELECT 
            "TV"."Fecha_hora_minuto" as t_emision,      
            SUM("KPI"."Visitas") as tot_visitas,
            SUM("TV"."Grps_ad16") as GRP,
            SUM(CASE WHEN "KPI"."Fecha_hora_minuto" > "TV"."Fecha_hora_minuto" THEN "KPI"."Visitas" ELSE 0 END) -
            SUM(CASE WHEN "KPI"."Fecha_hora_minuto" < "TV"."Fecha_hora_minuto" THEN "KPI"."Visitas" ELSE 0 END) as dif_visitas
        FROM
            "Marketing"."TV"
        LEFT JOIN
            "Marketing"."KPI" ON "KPI"."Fecha_hora_minuto" BETWEEN "TV"."Fecha_hora_minuto"- INTERVAL '5 minutes' AND "TV"."Fecha_hora_minuto" + INTERVAL '5 minutes'
        GROUP BY t_emision)
    SELECT
        t_emision,
        tot_visitas,
        GRP,
        dif_visitas
    FROM
        impacto
    ORDER BY
        t_emision;

-- Generar las gráficas de evolución de visitas y GRPs de los anuncios emitidos en TV.
SELECT * FROM "Marketing"."Impacto_TV"

-- ¿Qué anuncio obtiene mejor impacto tras su emisión?
SELECT * FROM "Marketing"."Impacto_TV"
JOIN "Marketing"."TV" ON t_emision = "TV"."Fecha_hora_minuto"
ORDER BY dif_visitas DESC;


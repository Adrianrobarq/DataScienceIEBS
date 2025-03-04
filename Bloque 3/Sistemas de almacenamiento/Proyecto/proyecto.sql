WITH impacto AS(    
    SELECT 
        "TV"."Fecha_hora_minuto" as t_emision,      
        SUM("KPI"."Visitas") as tot_visitas,
        SUM("TV"."Grps_ad16") as GRP
    FROM
        "Marketing"."TV"
    LEFT JOIN
        "Marketing"."KPI" ON "KPI"."Fecha_hora_minuto" BETWEEN "TV"."Fecha_hora_minuto" AND "TV"."Fecha_hora_minuto" + INTERVAL '20 minutes'
    GROUP BY t_emision)
SELECT
    t_emision,
    tot_visitas,
    GRP
FROM
    impacto
ORDER BY
	t_emision;
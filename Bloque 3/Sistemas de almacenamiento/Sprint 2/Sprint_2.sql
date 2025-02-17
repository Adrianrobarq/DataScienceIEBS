
--Enunciado y descripción: Crear una tabla que contenga:

--    la fecha (a nivel día)
--    visitas a la página web
--    unidades vendidas
--    importe
--    inversión publicitaria total
--    inversión publicitaria para cada medio (tv, radio y social)

--A partir de la tabla responder:

--  ¿En qué medio se ha gastado más presupuesto?
--  ¿Qué día se ha gastado mayor presupuesto publicitario?

--Entregable:

--    Queries utilizadas para crear la tabla.
--    Presentar un pantallazo con el resultado de una query que obtiene 10 registros.
--    Respuesta a las preguntas planteadas.

--Parte opcional:
--Además de la tabla anterior, cree una vista que contenga el mismo resultado que la tabla propuesta. ¿Qué ventajas tiene una vista sobre una tabla?
---

-- Creamos la tabla Publicitaria
CREATE TABLE IF NOT EXISTS "Marketing"."Publicitaria" (
    Fecha DATE,
    Visitas BIGINT, 
    Unidades_vendidas BIGINT, 
    Importe NUMERIC(15, 2), 
    Inversion_total NUMERIC(15, 2), 
    Inversion_tv NUMERIC(15, 2), 
    Inversion_radio NUMERIC(15, 2), 
    Inversion_social NUMERIC(15, 2))
TABLESPACE "pg_default";)

ALTER TABLE IF EXISTS "Marketing"."Publicitaria" 
    OWNER TO postgres;

COMMENT ON TABLE "Marketing"."Publicitaria"
    IS 'Tabla de datos que une información de las otras tablas.'

-- Generamos tabla con los datos solicitados
INSERT INTO "Marketing"."Publicitaria" (Fecha, Visitas, Unidades_vendidas, Importe, Inversion_tv, Inversion_radio, inversion_social)
SELECT
    DATE("KPI"."Fecha_hora_minuto") AS Fecha,
    SUM("KPI"."Visitas") AS Visitas,
    SUM("KPI"."Unidades vendidas") AS Unidades_vendidas,
    SUM("KPI"."Importe") AS Importe,
    SUM("TV"."Inversion") AS Inversion_tv,
    SUM("Radio"."Inversion") AS Inversion_radio,
    SUM("Social"."Inversion") AS Inversion_social
FROM
    "Marketing"."KPI"
    FULL JOIN "Marketing"."TV" ON DATE("KPI"."Fecha_hora_minuto") = DATE("TV"."Fecha_hora_minuto")
    FULL JOIN "Marketing"."Radio" ON DATE("KPI"."Fecha_hora_minuto") = DATE("Radio"."Fecha_hora_minuto")
    FULL JOIN "Marketing"."Social" ON DATE("KPI"."Fecha_hora_minuto") = DATE("Social"."Fecha")
GROUP BY
    Fecha;

UPDATE "Marketing"."Publicitaria"
SET
    inversion_social = "Social"."Inversion"*"Social".""
FROM
    "Marketing"."Social"
WHERE 
    DATE("Publicitaria"."fecha") = DATE("Social"."Fecha");
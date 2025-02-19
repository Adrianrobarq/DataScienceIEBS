
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
    Importe NUMERIC, 
    Inversion_tv NUMERIC, 
    Inversion_radio NUMERIC, 
    Inversion_social NUMERIC,
	Inversion_total NUMERIC)
TABLESPACE "pg_default";

ALTER TABLE IF EXISTS "Marketing"."Publicitaria" 
    OWNER TO postgres;

COMMENT ON TABLE "Marketing"."Publicitaria"
    IS 'Tabla de datos que une información de las otras tablas.'

-- Generamos tabla con los datos solicitados
INSERT INTO "Marketing"."Publicitaria" (Fecha, Visitas, Unidades_vendidas, Importe, Inversion_tv, Inversion_radio, inversion_social)
SELECT
	kpi.fecha as fecha, 
	kpi.visitas as visitas,
	kpi.Ventas as Unidades_vendidas,
	kpi.importe as Importe,
	TV.inversion_tv as Inversion_TV,
	Radio.inversion_ra as Inversion_radio,
	Social.inversion_so as inversion_social
FROM
	(SELECT DATE("KPI"."Fecha_hora_minuto") as fecha,
	SUM("KPI"."Visitas") as visitas,
	SUM("KPI"."Unidades vendidas") as Ventas,
	SUM("KPI"."Importe") as Importe
	FROM "Marketing"."KPI"
	GROUP BY fecha
	) kpi
	LEFT JOIN (SELECT
	DATE("TV"."Fecha_hora_minuto") as fecha,
	SUM("TV"."Inversion") as inversion_tv
	FROM "Marketing"."TV"
	GROUP BY fecha) TV
	ON kpi.fecha = TV.fecha
	LEFT JOIN (SELECT
	DATE("Radio"."Fecha_hora_minuto") as fecha,
	SUM("Radio"."Inversion") as inversion_ra
	FROM "Marketing"."Radio"
	GROUP BY fecha) Radio
	ON kpi.fecha = Radio.fecha
	LEFT JOIN (SELECT
	"Social"."Fecha" as fecha,
	SUM("Social"."Inversion") as inversion_so
	FROM "Marketing"."Social"
	GROUP BY fecha) Social
	ON kpi.fecha = social.fecha
ORDER BY
	kpi.fecha
-- Insertamos los null como valor = 0
UPDATE "Marketing"."Publicitaria"
SET inversion_tv = 0
WHERE "Publicitaria".inversion_tv IS NULL;

UPDATE "Marketing"."Publicitaria"
SET inversion_radio = 0 
WHERE "Publicitaria".inversion_radio IS NULL;

UPDATE "Marketing"."Publicitaria"
SET inversion_social = 0 
WHERE "Publicitaria".inversion_social IS NULL;

-- Calculamos la inversión total
UPDATE "Marketing"."Publicitaria"
SET inversion_total = "Publicitaria"."inversion_tv" + "Publicitaria"."inversion_radio" + "Publicitaria"."inversion_social";

-- Respondemos las preguntas
-- ¿En qué medio se ha gastado más presupuesto?
SELECT
	SUM(inversion_tv) as total_tv,
	SUM(inversion_radio) as total_radio,
	SUM(inversion_social) as total_social
FROM
	"Marketing"."Publicitaria"
-- Se gasta más en TV
-- ¿Qué día se gasta más presupuesto publicitario
SELECT
	fecha,
	inversion_total
FROM 
	"Marketing"."Publicitaria"
ORDER BY
	inversion_total DESC
LIMIT 1
-- El 25/3/2019 con 83581.54€

-- Query de 10 registros
SELECT *
FROM "Marketing"."Publicitaria"
LIMIT 10

--
-- USO DE GROUP BY Y FUNCIONES DE AGREGACION
--
-- EJERCICIO 1. PARA LA TABLA DE KPI, OBTENER:
-- a) EL PERIODO PARA EL CUAL HAY DATOS
-- b) EL TOTAL DE VISITAS RECIBIDAS
-- c) EL TOTAL DE UNIDADES VENDIDAS
-- d) EL TOTAL DE IMPORTE
SELECT
	DATE (MIN("KPI"."Fecha_hora_minuto")) AS FECHA_MINIMA,
	DATE (MAX("KPI"."Fecha_hora_minuto")) AS FECHA_MAXIMA,
	SUM("KPI"."Visitas") AS TOT_VISITAS,
	SUM("KPI"."Unidades vendidas") AS TOT_VENTAS,
	SUM("KPI"."Importe") AS TOT_BENEFICIO
FROM
	"Marketing"."KPI";

-- EJERCICIO 2. PARA CADA CADENA DE TV OBTENER:
-- a) NUMERO DE SPOTS EMITIDOS
-- b) TOTAL DE GRPS EMITIDOS
-- c) TOTAL DE INVERSION
-- d) COSTE POR GRP
SELECT
	"TV"."Cadena",
	COUNT("TV"."Fecha_hora_minuto") AS TOT_SPOTS,
	SUM("TV"."Grps_ad16") AS TOT_GRPS,
	SUM("TV"."Inversion") AS TOT_INVERSION,
	SUM("TV"."Inversion") / SUM("TV"."Grps_ad16") AS COSTE_GRP
FROM
	"Marketing"."TV"
GROUP BY
	"TV"."Cadena"
ORDER BY
	COSTE_GRP ASC;

-- EJERCICIO 3. RESPONDA A LAS SIGUIENTES PREGUNTAS SOBRE LA CAMPAÑA EN RADIO
-- a) PARA CADA EMISORA, ¿CUAL ES LA FRANJA HORARIA CON MAYOR COSTE POR GRP?
-- b) CUANTAS CUÑAS Y MENCIONES HA EMITIDO CADA EMISORA (USE LA SENTENCIA CASE WHEN)

SELECT
	"Radio"."Emisora",
	"Radio"."Franja",
	ROUND(
		SUM("Radio"."Inversion") / SUM("Radio"."Grps_ad16"),
		2
	) AS COSTE_GRP
FROM
	"Marketing"."Radio"
GROUP BY
	"Radio"."Emisora",
	"Radio"."Franja"
ORDER BY
	"Radio"."Emisora",
	"Radio"."Franja" ASC;

SELECT
	"Radio"."Emisora",
	SUM(
		CASE
			WHEN "Radio"."Formato" = 'CUÑA' THEN 1
			ELSE 0
		END
	) AS TOT_CUÑAS,
	SUM(
		CASE
			WHEN "Radio"."Formato" = 'MENCION' THEN 1
			ELSE 0
		END
	) AS TOT_MENCIONES
FROM
	"Marketing"."Radio"
GROUP BY
	"Radio"."Emisora";

-- EJERCICIO 4. PARA LA CAMPAÑA DE SOCIAL
-- a) CALCULA EL CPM Y CPC DE CADA CAMPAÑA
-- b) ¿QUE DIA SE OBTUVO EL MAYOR CTR?
-- CPM: Coste por mil impresiones = (Inversion / Impresiones) * 1000
-- CPC: Coste por click = Inversion / Clicks
-- CTR: Click Through Rate = Clicks / Impresiones
SELECT
	"Social"."Campaña",
	ROUND(SUM("Social"."Inversion") / SUM("Social"."Impresiones") * 1000, 3)  AS CPM,
	ROUND(SUM("Social"."Inversion") / SUM("Social"."Clics"),3) AS CPC
FROM
	"Marketing"."Social"
GROUP BY
	"Social"."Campaña";
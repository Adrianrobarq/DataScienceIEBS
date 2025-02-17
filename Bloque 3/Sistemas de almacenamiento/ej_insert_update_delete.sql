-- EJERCICIO 1. INSERTA UN REGISTRO EN LA TABLA KPI DONDE:
-- FECHA_HORA_MINUTO = 2024-01-15 12:30:00
-- DISPOSITIVO = iOS
-- VISITAS = 100
-- UNIDADES_VENDIDAS = 5
-- IMPORTE = NULL

SELECT COUNT (*) 
FROM "Marketing"."KPI" ;
-- Resultado: 267840

INSERT INTO "Marketing"."KPI" 
VALUES ('2024-01-15 12:30:00', 'iOS', 100, 5, NULL) ;

SELECT COUNT (*) 
FROM "Marketing"."KPI" ;
-- Resultado: 267841

-- EJERCICIO 2. ACTUALIZA EL VALOR DE IMPORTE DEL REGISTRO ANTERIOR CON UN VALOR DE 20.5

UPDATE "Marketing"."KPI"
SET "Importe" = 20.5
WHERE "KPI"."Fecha_hora_minuto" = '2024-01-15 12:30:00' and "KPI"."Dispositivo" = 'iOS' ;

SELECT *
FROM "Marketing"."KPI"
WHERE "KPI"."Fecha_hora_minuto" = '2024-01-15 12:30:00' and "KPI"."Dispositivo" = 'iOS' ;

-- EJERCICIO 3. BORRA EL REGISTRO QUE HAS CREADO

DELETE FROM "Marketing"."KPI"
WHERE "KPI"."Fecha_hora_minuto" = '2024-01-15 12:30:00' and "KPI"."Dispositivo" = 'iOS' ;

SELECT COUNT (*) 
FROM "Marketing"."KPI" ;
-- Resultado: 267840
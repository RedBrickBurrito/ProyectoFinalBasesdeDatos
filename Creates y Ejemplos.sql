--1.
CREATE FUNCTION RegresaR (@rango1 int, @rango2 int)
RETURNS TABLE
AS
RETURN
(
	SELECT Profesores.Nomina, Evaluaciones.Fecha, Profesores.Nombres, Profesores.Apellidos, (Pon1 + Pon2 + Pon3 + Pon4 + Pon5 + Pon6)/6 AS Promedio 
	FROM Evaluaciones JOIN Profesores ON Evaluaciones.Nomina = Profesores.Nomina
	WHERE (Pon1 + Pon2 + Pon3 + Pon4 + Pon5 + Pon6)/6 >= @rango1 AND (Pon1 + Pon2 + Pon3 + Pon4 + Pon5 + Pon6)/6 <= @rango2
);
GO

SELECT * FROM RegresaR(50,80);

--2. + 3.
CREATE PROCEDURE RegresaN
@Nombre varchar(50),
@Apellido varchar(50),
@Fecha smalldatetime
AS
DECLARE @Nominas nchar(9)
IF @Fecha IS NULL
BEGIN
	SELECT * FROM Profesores 
	WHERE Nombres LIKE '%' + @Nombre + '%'  AND Apellidos LIKE '%' + @Apellido + '%'

	SELECT * FROM Evaluaciones 
	JOIN Profesores ON Evaluaciones.Nomina = Profesores.Nomina
	WHERE Nombres LIKE '%' + @Nombre + '%'  AND Apellidos LIKE '%' + @Apellido + '%'
END
ELSE
BEGIN
		SELECT * FROM Profesores 
	WHERE Nombres LIKE '%' + @Nombre + '%'  AND Apellidos LIKE '%' + @Apellido + '%'

	SELECT * FROM Evaluaciones 
	JOIN Profesores ON Evaluaciones.Nomina = Profesores.Nomina
	WHERE Nombres LIKE '%' + @Nombre + '%'  AND Apellidos LIKE '%' + @Apellido + '%' AND Fecha = @Fecha
END
GO

EXEC RegresaN 'Geronimo', 'Duplicado', NULL
EXEC RegresaN 'Geronimo', 'Duplicado', '2020-05-10 00:00:00'

--4.
CREATE PROCEDURE InsertarComentario
@NombreProf varchar (50),
@ApellidoProf varchar (50),
@ComentarioProf varchar (200)

AS

DECLARE @NoProfs INT
SELECT @NoProfs = COUNT(Nomina) FROM Profesores WHERE Nombres LIKE '%' + @NombreProf + '%'  AND Apellidos LIKE '%' + @ApellidoProf + '%'

    IF @NoProfs = 1
    BEGIN
        DECLARE @Nomina nchar(9)
        SELECT @Nomina = Nomina FROM Profesores WHERE Nombres LIKE '%' + @NombreProf + '%'  AND Apellidos LIKE '%' + @ApellidoProf + '%'
        INSERT INTO Comentarios(Nomina, Fecha, Comentario) VALUES (@Nomina, GETDATE(), @ComentarioProf)
    END
    ELSE
    BEGIN
        PRINT 'Hay mas de un profe con ese nombre, busque con nomina: InsertarComentarioNomina ''Nomina'' ''Comentario'''
    END
GO

EXEC InsertarComentario 'Geronimo', 'Duplicado', 'Por que se llaman igual?'

CREATE PROCEDURE InsertarComentarioNomina
@Nomina nchar(9),
@ComentarioProf nchar(200)

AS

    IF EXISTS (SELECT * FROM Profesores WHERE Nomina = @Nomina)
    BEGIN
        INSERT INTO Comentarios(Nomina, Fecha, Comentario) VALUES (@Nomina, GETDATE(), @ComentarioProf)
    END
GO

EXEC InsertarComentarioNomina 'L00842300', 'Ahora sí, por que se llaman igual'

--5
CREATE PROCEDURE RegresaAgendaHoy
@Dias INT

AS
SELECT Distinct Evaluaciones.Nomina, Nombres, Apellidos FROM Evaluaciones JOIN Profesores on Evaluaciones.Nomina = Profesores.Nomina WHERE Fecha < DATEADD(DAY, -@Dias, CURRENT_TIMESTAMP) 
GO

EXEC RegresaAgendaHoy '300'
EXEC RegresaAgendaHoy '1'

--6
CREATE PROCEDURE BorraComentario
@Nomina nchar(9),
@Fecha smalldatetime

AS
IF EXISTS(SELECT Comentario FROM Comentarios WHERE @Nomina = Nomina AND @Fecha = Fecha)
BEGIN
	DELETE FROM Comentarios WHERE @Nomina = Nomina AND @Fecha = Fecha
END
ELSE
BEGIN
	PRINT 'Algunos de los datos proporcionados estaba incorrecto, intentelo de nuevo'
END
GO

EXEC BorraComentario 'L01568170', '2020-06-03 21:59:00'

--7
CREATE PROCEDURE ActualizaRubro
@Columna int,
@Nomina nchar(9),
@NuevaCalif int
AS
DECLARE @NominaCount int
SELECT  @NominaCount = Count(DISTINCT Nomina) FROM Evaluaciones WHERE Nomina = @Nomina

BEGIN TRAN

IF @NominaCount != 1 OR @Columna < 1 OR @Columna > 6
BEGIN 
	PRINT 'Revisa la Nomina y Columna'
	ROLLBACK TRANSACTION
END

ELSE
BEGIN
   SELECT TOP 1 *
   FROM Evaluaciones
   WHERE Nomina = @Nomina
   ORDER BY Fecha DESC

	IF @Columna = 1
	BEGIN
	WITH CTE AS 
	   (
	   SELECT TOP 1 *
	   FROM Evaluaciones
	   WHERE Nomina = @Nomina
	   ORDER BY Fecha DESC
	   )
	   UPDATE CTE SET Pon1 = @NuevaCalif
	END

	IF @Columna = 2
	BEGIN
	WITH CTE AS 
	   (
	   SELECT TOP 1 *
	   FROM Evaluaciones
	   WHERE Nomina = @Nomina
	   ORDER BY Fecha DESC
	   )
	   UPDATE CTE SET Pon2 = @NuevaCalif
	END

	IF @Columna = 3
	BEGIN
	WITH CTE AS 
	   (
	   SELECT TOP 1 *
	   FROM Evaluaciones
	   WHERE Nomina = @Nomina
	   ORDER BY Fecha DESC
	   )
	   UPDATE CTE SET Pon3 = @NuevaCalif
	END

	IF @Columna = 4
	BEGIN
	WITH CTE AS 
	   (
	   SELECT TOP 1 *
	   FROM Evaluaciones
	   WHERE Nomina = @Nomina
	   ORDER BY Fecha DESC
	   )
	   UPDATE CTE SET Pon4 = @NuevaCalif
	END

	IF @Columna = 5
	BEGIN
	WITH CTE AS 
	   (
	   SELECT TOP 1 *
	   FROM Evaluaciones
	   WHERE Nomina = @Nomina
	   ORDER BY Fecha DESC
	   )
	   UPDATE CTE SET Pon5 = @NuevaCalif
	END

	IF @Columna = 6
	BEGIN
	WITH CTE AS 
	   (
	   SELECT TOP 1 *
	   FROM Evaluaciones
	   WHERE Nomina = @Nomina
	   ORDER BY Fecha DESC
	   )
	   UPDATE CTE SET Pon6 = @NuevaCalif
	END

	   SELECT TOP 1 *
	   FROM Evaluaciones
	   WHERE Nomina = @Nomina
	   ORDER BY Fecha DESC

	COMMIT
END
GO

EXEC ActualizaRubro 2, 'L01568072', 30

--8
CREATE PROCEDURE Reporte
@Rango1fecha SMALLDATETIME,
@Rango2fecha SMALLDATETIME
AS
SELECT Profesores.Nomina, Nombres, Apellidos FROM Profesores 
JOIN Comentarios ON Comentarios.Nomina = Profesores.Nomina
WHERE NOT (Comentarios.Fecha > @Rango2fecha AND Comentarios.Fecha < @Rango1fecha)
GO

EXEC Reporte '2020-06-03 21:53:00','2020-06-03 21:59:00'

--Views por tablas
CREATE VIEW Comment AS
SELECT *
FROM Comentarios
GO

CREATE VIEW Eval AS
SELECT *
FROM Evaluaciones
GO

CREATE VIEW Prof AS
SELECT *
FROM Profesores
GO
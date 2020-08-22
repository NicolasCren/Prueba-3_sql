--CREATE DE LAS TABLAS DE LA PRUEBA PROBLEMA 1 :
CREATE TABLE Cliente (
id_cliente INT PRIMARY KEY NOT NULL,
dire_cliente VARCHAR(50),
saldo INT,
limite_cre INT,
);

CREATE TABLE Articulos(
id_articulo INT PRIMARY KEY NOT NULL,
Fabrica VARCHAR (50),
existencia INT, 
descripcion VARCHAR(50)
);

CREATE TABLE Pedido(
fid_cliente INT NOT NULL,
envio VARCHAR (50) NOT NULL,
fecha DATE NOT NULL,
fid_articulo INT NOT NULL,
cantidad INT,
FOREIGN KEY (fid_cliente) REFERENCES Cliente(id_cliente),
FOREIGN KEY (fid_articulo) REFERENCES ARTICULOS(id_articulo)
);

--SELECT PARA VERIFICAR DATOS

SELECT * FROM Cliente;
SELECT * FROM Articulos;
SELECT * FROM Pedido;

--PROCEDIMIENTOS ALMACENADOS PARA CLIENTE 

CREATE OR ALTER PROCEDURE agregar_cliente   
@id INT,
@dir VARCHAR(50),
@saldo INT,
@limte INT
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM dbo.Cliente WHERE id_cliente=@id)
	BEGIN
	INSERT INTO dbo.Cliente(id_cliente,dire_cliente,saldo,limite_cre)
	VALUES(@id,@dir,@saldo,@limte)

	END
END

CREATE OR ALTER PROCEDURE eliminar_cliente
@id INT,
@aux INT OUT
AS
BEGIN
	IF EXISTS (SELECT * FROM dbo.Cliente WHERE id_cliente=@id )
			BEGIN
				DELETE FROM dbo.Cliente WHERE id_cliente=@id
				SET @aux=1;
			END
END
--PROCEDIMIENTOS ALMACENADOS PARA ARTICULOS

CREATE OR ALTER PROCEDURE agregar_articulo  
@id INT,
@fabrica VARCHAR(50),
@existencia INT,
@descripcion VARCHAR(50)
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM dbo.ARTICULOS WHERE id_articulo=@id)
			BEGIN
				INSERT INTO dbo.ARTICULOS(id_articulo,Fabrica,existencia,descripcion)
				VALUES(@id,@fabrica,@existencia,@descripcion)

			END
END


CREATE OR ALTER PROCEDURE eliminar_articulo
@id INT,
@aux INT OUT
AS
BEGIN
	IF EXISTS (SELECT * FROM dbo.Articulos WHERE id_articulo=@id )
			BEGIN
				DELETE FROM dbo.Articulos WHERE id_articulo=@id
				SET @aux=1;
			END
END

--PROCEDIMIENTOS ALMACENADOS PARA PEDIDOS

CREATE OR ALTER PROCEDURE agregar_pedido  
@id_cliente INT,
@envio VARCHAR(50),
@fecha DATE,
@id_articulo INT,
@cantidad INT
AS
BEGIN	
	INSERT INTO dbo.Pedido(fid_cliente,envio,fecha,fid_articulo,cantidad)
	VALUES(@id_cliente,@envio,@fecha,@id_articulo,@cantidad)
END


CREATE OR ALTER PROCEDURE eliminar_pedido
@id_cliente INT,
@id_articulo INT,
@aux INT OUT
AS
BEGIN
	IF EXISTS (SELECT * FROM dbo.Pedido WHERE fid_articulo=@id_articulo AND fid_cliente=@id_cliente )
			BEGIN
				DELETE FROM dbo.Pedido WHERE fid_articulo=@id_articulo AND fid_cliente=@id_cliente 
				SET @aux=1;
			END
END












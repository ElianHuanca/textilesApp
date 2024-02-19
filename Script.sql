CREATE TABLE IF NOT EXISTS sucursales(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100),
	--idusers INT,
	--CONSTRAINT fk_users FOREIGN KEY (idusers) REFERENCES users(id) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS suc_telas(
	id SERIAL PRIMARY KEY,
	idsucursales INT,
	idtelas INT,
	seleccionado boolean DEFAULT TRUE,
	CONSTRAINT fk_telas FOREIGN KEY (idtelas) REFERENCES telas(id) ON DELETE CASCADE ON UPDATE RESTRICT,
	CONSTRAINT fk_sucursales FOREIGN KEY (idsucursales) REFERENCES sucursales(id) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS telas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    precxmay DOUBLE PRECISION,
    precxmen DOUBLE PRECISION,
    precxrollo DOUBLE PRECISION,
    precxcompra DOUBLE PRECISION,
	idusers int,
	CONSTRAINT fk_users FOREIGN KEY (idusers) REFERENCES users(id) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS ventas (
    id SERIAL PRIMARY KEY,
    fecha DATE,
    total DOUBLE precision default 0,
    ganancias DOUBLE precision default 0
);

CREATE TABLE IF NOT EXISTS det_ventas (
    id SERIAL PRIMARY KEY,
    idventas INT,
    idtelas INT,
    precio DOUBLE PRECISION,
    cantidad DOUBLE PRECISION,
    CONSTRAINT fk_ventas FOREIGN KEY (idventas) REFERENCES ventas(id) ON DELETE CASCADE ON UPDATE RESTRICT,
    CONSTRAINT fk_telas FOREIGN KEY (idtelas) REFERENCES telas(id) ON DELETE CASCADE ON UPDATE RESTRICT
);

INSERT INTO sucursales (nombre) VALUES


INSERT INTO telas(nombre,precxmen, precxmay, precxrollo,precxcompra) VALUES
(1, 'Razo Suizo Licra', 30, 25, 23, 20),
(2, 'Razo Suizo Rigido', 25, 20, 18, 15),
(3, 'Lipiur 3D', 160, 130, 110, 100),
(4, 'Mostazilla', 180, 150, 140, 110),
(5, 'Lipiur', 130, 100, 85, 70),
(6, 'Razo Doble Ancho', 20, 15, 14, 11),
(7, 'Razo', 10, 8, 6, 5.5),
(8, 'Tull Ramas',65,55,50, 40),
(9, 'Blonda 15',15,12,10,8),
(10, 'Blonda 20',20,15,12, 10),
(11, 'Blonda 50',50,45,43, 35),
(12,'Tull Ilusion',10,8,6, 5.5),
(13, 'Tull Licra',20,16,15,8),
(14, 'Tull Frances',25,20,18,16),
(15, 'Can Can',20,17,14,12),
(16, 'Tull Maripozas LPZ',65,50,45,40),
(17,'Tull Americano', 20,17,15,11.5),
(18,'lipiur AG', 130,100,85,62),
(19,'Tull Perlado', 100,80,70,46),
(20,'Bonye', 10,8,6,5.5),
(21, 'Tull Brilloso',23,18,15,12),
(22, 'Lipiur IH',130,100,85,57),
(23, 'Lipiur Blonda',60,50,45,40),
(24,'gasa',15,12,10,9),
(25, 'Tull Ramas Ramada', 65,55,50,40);
--(27, 'Blonda 30',30,25,20, 18),
--(28, 'Blonda 12',12,10,8, 6),
--(29,'Gasa Cuadros',20,15,14,12),

insert into ventas(fecha) values
('14-06-2023'),
('17-06-2023'),
('21-06-2023'),
('24-06-2023'),
('28-06-2023'),
('01-07-2023'),
('05-07-2023'),
('08-07-2023'),
('12-07-2023');

-- Crear la función que se ejecutará en el trigger
CREATE OR REPLACE FUNCTION actualizar_total_ingresos()
RETURNS TRIGGER AS $$
DECLARE
    precioxcompra numeric; -- Declarar la variable para almacenar el precio de compra
BEGIN
    -- Obtener el precio de compra de la tela
    SELECT telas.precxcompra INTO precioxcompra FROM telas WHERE id = NEW.idtelas;

    -- Actualizar el total y los ingresos de la venta
    UPDATE ventas
    SET total = total + (NEW.cantidad * NEW.precio),
        ganancias = ganancias + ((NEW.precio - precioxcompra) * NEW.cantidad)
    WHERE id = NEW.idventas;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger AFTER INSERT en la tabla det_ventas
CREATE TRIGGER det_venta_after_insert
AFTER INSERT ON det_ventas
FOR EACH ROW
EXECUTE FUNCTION actualizar_total_ingresos();


--14/06/23
insert into det_ventas(idventas,idtelas,cantidad,precio) VALUES
	(1,16,6.4, 80),
	(1,8,4.6, 60),
	(1,3,6.7, 140),
	(1,1,6, 30),
	(1,14,1.5, 23.33),
	(1,3,1.75, 130),
	(1,2,1, 20),
	(1,5,0.5, 130),
	(1,26,0.5, 60),TULL FLORES
	(1,8,11.2, 55),
	(1,3,2, 150),
	(1,2,1, 25);

--17-06-2023
insert into det_ventas(idventas,idtelas,cantidad,precio) VALUES
	(2,16,3, 60),
	(2,15,1.5, 17),
	(2,2,0.5, 25),
	(2,6,2, 20),
	(2,2,1.5, 25),
	(2,5,1, 120),
	(2,5,1, 110),
	(2,14,3, 25),
	(2,15,2.5, 20),
	(2,21,1, 23),
	(2,23,0.5, 60),
	(2,8,2, 65),
	(2,5,3, 110),
	(2,1,6.5, 25),
	(2,26,1.5, 60),
	(2,2,6, 22),
	(2,15,1.5, 17),
	(2,16,1, 60),--TULL MARIPOSAS LPZ?
	(2,5,0.5, 130);

--21-06-2023
insert into det_ventas(idventas,idtelas,cantidad,precio) values
	(3,1,3, 30),
	(3,5,1.5, 120),
	(3,8,1, 65),
	(3,5,0.75, 130),
	(3,2,22, 20),
	(3,3,3, 130),
	(3,1,3, 27),
	(3,5,3, 110),
	(3,5,1, 110),
	(3,1,4, 30),
	(3,11,0.5, 50),
	(3,10,2, 20),
	(3,9,2, 15),
	(3,10,6, 20),
	(3,12,3, 10),
	(3,12,3, 10),
	(3,1,10, 25),
	(3,13,1, 20),
	(3,2,5, 21);

--24-06-2023
insert into det_ventas(idventas,idtelas,cantidad,precio) VALUES
	(4,5,9, 120),
	(4,8,2, 55),
	(4,26,1, 60),
	(4,6,15.5, 16),
	(4,20,12, 8),
	(4,15,5, 18),
	(4,1,4, 28),
	(4,10,9, 17),
	(4,14,1.9, 22),
	(4,16,1, 60),
	(4,7,2, 10),
	(4,2,3, 25),
	(4,3,14.25, 120),
	(4,16,1.75, 60),
	(4,15,2, 20),
	(4,2,1.5, 25),
	(4,23,1.5, 60),
	(4,1,5, 27),
	(4,14,1, 25),
	(4,16,2.5, 60),
	(4,15,5, 17),
	(4,5,1.5, 120),
	--(4,,20, 25),BLONDA 25 30???
	(4,12,4, 10);

--28-06-2023
insert into det_ventas(idventas,idtelas,cantidad,precio) VALUES
	(5,8,4, 55),
	(5,8,3, 60),
	(5,14,1, 25),
	(5,1,1, 30),
	(5,9,30, 11),
	(5,1,25, 25),
	(5,10,2.5, 18),
	(5,3,2, 130),
	(5,16,4, 55),
	(5,8,1, 55),
	(5,5,1, 120),--LIPIUR SOLO BORDADO?
	(5,5,0.9, 100),
	(5,15,3, 20),
	(5,14,3, 25),
	(5,10,30, 13),
	(5,16,1, 60);

--01-07-2023
insert into det_ventas(idventas,idtelas,cantidad,precio) VALUES
	(6,14,1, 25),
	(6,6,10, 15),
	(6,8,3.2, 60),
	(6,16,1, 60),
	(6,6,4, 20),
	(6,5,1.5, 120),
	(6,16,2.5, 60),
	(6,23,1, 60),
	(6,8,0.5, 60),
	(6,5,1, 130),
	(6,14,1.5, 25),
	(6,5,4, 110),
	(6,9,3, 12),--BLONDA 12???
	(6,1,2, 27),
	(6,5,0.5, 130),
	(6,5,1, 120),
	(6,15,3, 20),
	(6,1,4.5, 30),
	(6,2,2, 20),
	(6,5,2.5, 120),
	(6,23,1.15, 60),
	(6,1,1.5, 30),
	(6,2,1.25, 25),
	(6,14,3, 23),
	(6,12,5, 10),
	(6,27,0.5, 30);--BLONDA 30?
	
--05-07-2023
insert into det_ventas(idventas,idtelas,cantidad,precio) VALUES
(7,21,10, 18),
	--(7,27,10, 30), QUE BLONDA 50?
	(7,5,2, 120),
	(7,1,2.5, 30),
	(7,14,3, 25),
	(7,3,1.5, 160),
	(7,1,0.5, 30),
	(7,2,4, 25),
	(7,21,10, 18),
	(7,15,5, 17),
	(7,15,1, 20),
	(7,26,1, 58),
	(7,5,1, 120),
	(7,16,4, 58),
	(7,14,2, 22),
	(7,1,6, 28),
	(7,5,1.5, 125),
	(7,12,3, 10),
	(7,1,25, 24),
	(7,8,1, 65),
	(7,29,1.5, 20),
	(7,3,1, 150),
	(7,14,10, 20),
	(7,1,1, 30),
	(7,8,2.5, 55),
	(7,16,7, 60),
	(7,21,4, 20),
	(7,1,3, 25),
	(7,14,1, 25);

--08-07-2023
insert into det_ventas(idventas,idtelas,cantidad,precio) VALUES
(8,16,2.5, 60),
	(8,15,6, 20),
	(8,4,0.5, 180),
	(8,1,1.5, 25),
	(8,5,1, 130),
	(8,16,6, 55),
	(8,6,5, 18),
	(8,14,1.5, 25),
	(8,9,3, 15),
	(8,20,4, 8),
	(8,5,1, 120),
	(8,16,7.7, 55),
	(8,1,6, 30),
	(8,20,3, 10),
	(8,8,2, 55),
	(8,8,1, 65),
	(8,5,1, 125),
	(8,2,1, 25),
	(8,3,2, 130),
	(8,5,1.5, 130),
	--(8,,1, 120), LIPIUR SOLO BORDADO?
	(8,13,0.5, 20),
	(8,20,3, 10),
	(8,1,3, 25);


--12-07-2023
insert into det_ventas(idventas,idtelas,cantidad,precio) VALUES
(9,1,4, 25),
	(9,12,1, 10),
	(9,14,1, 25),
	(9,9,2, 12.5),
	(9,21,7, 23),
	(9,5,1.5, 123),
	(9,2,1.5, 25),
	(9,8,1.4, 65),
	--(9,,1, 60), TULL FLORES BRILLOSO
	(9,15,20, 16),
	(9,1,24, 24),
	(9,5,0.5, 130),
	(9,12,8, 10),
	(9,10,1, 20),
	(9,3,1.5, 160),
	(9,1,3.5, 28.5),
	(9,5,1, 120),
	(9,1,1.2, 30),
	(9,5,1.5, 120),
	(9,1,3, 30),
	(9,1,0.75, 30),
	(9,16,0.5, 60),
	(9,10,0.5, 20);

/*select * from ventas
SELECT ventas.fecha, det_ventas.*
FROM ventas, det_ventas
WHERE det_ventas.idventas = ventas.id;*/




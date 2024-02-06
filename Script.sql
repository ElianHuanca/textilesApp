CREATE TABLE IF NOT EXISTS telas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    precxmay DOUBLE PRECISION,
    precxmen DOUBLE PRECISION,
    precxrollo DOUBLE PRECISION,
    precxcompra DOUBLE PRECISION
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

INSERT INTO telas(id, nombre, precxmay, precxmen, precxrollo) VALUES
(1, 'Razo Suizo Licra', 30, 25, 25),
(2, 'Razo Suizo Rigido', 25, 20, 20),
(3, 'Lipiur 3D', 160, 130, 120),
(4, 'Mostazilla', 180, 160, 150),
(5, 'Lipiur', 130, 100, 95),
(6, 'Razo Doble Ancho', 20, 17, 16),
(7, 'Razo', 10, 8, 7),
(8, 'Tull Ramas',65,55,50),
(9, 'Blonda 15',15,12,10),
(10, 'Blonda 20',20,15,13),
(11, 'Blonda 50',20,15,13),
(12,'Tull Ilusion',10,8,6),
(13, 'Tull Licra',20,17,16),
(14, 'Tull Frances',25,20,18),
(15, 'Can Can',20,17,16);

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
CREATE OR REPLACE FUNCTION actualizar_total_venta()
RETURNS TRIGGER AS $$
BEGIN
    -- Calcular la suma de cantidad y precio de la fila insertada en det_ventas
    UPDATE ventas
    SET total = total + (NEW.cantidad * NEW.precio)
    WHERE id = NEW.idventas;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger AFTER INSERT en la tabla det_ventas
CREATE TRIGGER det_venta_after_insert
AFTER INSERT ON det_ventas
FOR EACH ROW
EXECUTE FUNCTION actualizar_total_venta();



insert into det_ventas(idventas,idtelas,cantidad,precio) values
	(1,1,3, 30),
	(1,5,1.5, 120),
	(1,8,1, 65),
	(1,5,0.75, 130),
	(1,2,22, 20),
	(1,3,3, 130),
	(1,1,3, 27),
	(1,5,3, 110),
	(1,5,1, 110),
	(1,1,4, 30),
	(1,11,0.5, 50),
	(1,10,2, 20),
	(1,9,2, 15),
	(1,10,6, 20),
	(1,12,3, 10),
	(1,12,3, 10),
	(1,1,10, 25),
	(1,13,1, 20),
	(1,2,5, 21);

select * from ventas

SELECT ventas.fecha, det_ventas.*
FROM ventas, det_ventas
WHERE det_ventas.idventas = ventas.id;




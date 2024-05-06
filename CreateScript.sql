CREATE TABLE IF NOT EXISTS usuarios(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100),
	correo VARCHAR(100) unique,
	password VARCHAR(255),
	token text,
	estado boolean default true
);

CREATE TABLE IF NOT EXISTS sucursales(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(100),
	idusuarios INT,
	estado boolean default true,
	CONSTRAINT fk_usuarios FOREIGN KEY (idusuarios) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS telas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),	
    precxmay  FLOAT default 0,
    precxmen  FLOAT default 0,
    precxrollo  FLOAT default 0,
    precxcompra  FLOAT default 0,
	idusuarios int,
	estado boolean default true,
	CONSTRAINT fk_usuarios FOREIGN KEY (idusuarios) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS ventas (
    id SERIAL PRIMARY KEY,
    fecha DATE default NOW(),
    total DOUBLE PRECISION default 0,
    ganancias DOUBLE PRECISION default 0,
    descuento  FLOAT default 0,
    idsucursales INT,
	estado boolean default true,
    CONSTRAINT fk_sucursales FOREIGN KEY (idsucursales) REFERENCES sucursales(id) ON DELETE CASCADE ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS det_ventas (
    id SERIAL PRIMARY KEY,
    idventas INT,
    idtelas INT,
    precio FLOAT,
    cantidad NUMERIC(6, 2),
    total DOUBLE PRECISION,
	ganancias DOUBLE PRECISION ,
	estado boolean default true,
    CONSTRAINT fk_ventas FOREIGN KEY (idventas) REFERENCES ventas(id) ON DELETE CASCADE ON UPDATE RESTRICT,
    CONSTRAINT fk_telas FOREIGN KEY (idtelas) REFERENCES telas(id) ON DELETE CASCADE ON UPDATE RESTRICT
);







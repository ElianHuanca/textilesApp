CREATE TABLE IF NOT EXIST rango(
    id serial primary key,
    nombre varchar(100) not null,
);

INSERT INTO rango(nombre) VALUES
('Elite'),
('Legendario');


CREATE TABLE IF NOT EXIST heroes(
    id serial primary key,
    nombre varchar(100) not null,
    rango_id integer not null default 1,
    FOREIGN KEY (rango_id) REFERENCES rango(id)
);



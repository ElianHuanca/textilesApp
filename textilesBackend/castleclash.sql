CREATE TABLE IF NOT EXIST rango(
    id serial primary key,
    nombre varchar(100) not null,
);

INSERT INTO rango(nombre) VALUES
('Elite'),
('Legendario');

CREATE TABLE IF NOT EXIST habilidades(
    id serial primary key,
    nombre varchar(100) not null,        
);

INSERT INTO habilidades (nombre) VALUES
('Sed De Sangre'),
('Empoderar'),
('Armadura Perversa'),

CREATE TABLE IF NOT EXISTE emblemas(
    id serial primary key,
    nombre varchar(100) not null,
);

INSERT INTO emblemas(nombre)values
('Renacer Alado'),
('Escudo Legitimo'),

CREATE TABLE IF NOT EXISTE encantamientos(
    id serial primary key,
    nombre varchar(100) not null,
);

INSERT INTO encantamientos(nombre)values
('Condena Eterna')

CREATE TABLE IF NOT EXISTE atributos(
    id serial primary key,
    nombre varchar(100) not null,
);

INSERT INTO atributos(nombre) VALUES
('Precision'),
('Ataque'),
('Velocidad'),
('PS'),
('Defensa'),
('Daño Crítico');

CREATE TABLE IF NOT EXIST heroes(
    id serial primary key,
    nombre varchar(100) not null,
    rango_id integer not null default 1,
    habilidad boolean default false,
    habilidad2 boolean default false,
    emblema boolean default false,
    encantamiento boolean default false,
    atributo boolean default false,
    FOREIGN KEY (rango_id) REFERENCES rango(id),
    habilidad_id integer not null,
    FOREIGN KEY (habilidad_id) REFERENCES habilidades(id)
    habilidad_id2 integer not null,
    FOREIGN KEY (habilidad_id2) REFERENCES habilidades(id)
    emblema_id integer not null,
    FOREIGN KEY (emblema_id) REFERENCES emblemas(id),
    encantamiento_id integer not null,
    FOREIGN KEY (encantamiento_id) REFERENCES encantamientos(id),
    atributo_id integer not null,
    FOREIGN KEY (atributo_id) REFERENCES atributos(id),
);

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Guerrero Mako', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e , encantamientos as en, atributos as a
WHERE h1.nombre = 'Sed De Sangre' AND h2.nombre = 'Empoderar' AND e.nombre = 'Renacer Alado' AND en.nombre = 'Condena Eterna' AND a.nombre = 'Precision';


INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Simio Borracho', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Luz Sagrada' AND h2.nombre = 'Armadura Perversa' AND e.nombre = 'Escudo Legitimo' AND en.nombre = 'Condena Eterna' AND a.nombre = 'Precision';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Serratico', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Sed De Sangre' AND h2.nombre = 'Empoderar' AND e.nombre = 'Renacer Alado' AND en.nombre = 'Ambicion Audaz' AND a.nombre = 'Precision';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Golem Primitivo', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Baston De Errante' AND h2.nombre = 'Armadura Perversa' AND e.nombre = 'Armadura Del Caos' AND en.nombre = 'Condena Eterna' AND a.nombre = 'Precision';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Pugilistica Cosmico', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Armadura Perversa' AND h2.nombre = 'Empoderar' AND e.nombre = 'Motivacion' AND en.nombre = 'Condena Eterna' AND a.nombre = 'Evasion';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Guerrero Del Norte', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Revivir' AND h2.nombre = 'Revitalizar' AND e.nombre = 'Renacer Alado' AND en.nombre = 'Condena Eterna' AND a.nombre = 'Precision';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Constrictora', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Escudo Del Dragon' AND h2.nombre = 'Luz Sagrada' AND e.nombre = 'Armadura Del Caos' AND en.nombre = 'Condena Eterna' AND a.nombre = 'Precision';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Dynamica', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Ardor De Batalla' AND h2.nombre = 'Luz Sagrada' AND e.nombre = 'Renacer Alado' AND en.nombre = 'Condena Eterna' AND a.nombre = 'Precision';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Mistrix', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Revivir' AND h2.nombre = 'Empoderar' AND e.nombre = 'Percepcion Antigua' AND en.nombre = 'Condena Eterna' AND a.nombre = 'PS';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Cazadora Lunar', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Luz Sagrada' AND h2.nombre = 'Empoderar' AND e.nombre = 'Renacer Alado' AND en.nombre = 'Condena Eterna' AND a.nombre = 'Precision';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Experto En Dragones', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Luz Sagrada' AND h2.nombre = 'Empoderar' AND e.nombre = 'Renacer Alado' AND en.nombre = 'Condena Eterna' AND a.nombre = 'Precision';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Flutterella', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Luz Sagrada' AND h2.nombre = 'Empoderar' AND e.nombre = 'Renacer Alado' AND en.nombre = 'Condena Eterna' AND a.nombre = 'PS';

INSERT INTO heroes (nombre,habilidad_id,habilidad_id2,emblema_id,encantamiento_id,atributo_id)
SELECT 'Diosa De Las Flores', h1.id, h2.id, e.id, en.id, a.id
FROM habilidades as h1, habilidades as h2, emblemas as e, encantamientos as en, atributos as a
WHERE h1.nombre = 'Luz Sagrada' AND h2.nombre = 'Empoderar' AND e.nombre = 'Renacer Alado' AND en.nombre = 'Condena Eterna' AND a.nombre = 'PS';



INSERT INTO heroes (nombre)VALUES 
('Apostol Del Abismo'),
('Patrono De Almas'),
('Espectro De Rosas'),
('Mal De Ojo'),
('Caballero Del Vacio'),
('Cuervo Asesino'),
('Sabio De La Espada'),
('Juez Del Inframundo'),
('Pintora De Maleficios'),
('Lancero Espartano'),
('Sepultero'),
('Asesino Ardiente'),
('Espiritu Felino'),
('Maestro Tiranico'),
('Merksha'),
('Bermellona'),
('Inquisidora'),
('Dama Mecanica'),
('Droide Gentil'),
('Conjuradora'),
('Jinete Barbara'),
('Arpista Afligido'),
('Colloso'),
('Momia Real'),
('Heredero Gelido'),
('Masacre'),
('Inventor Loco'),
('Sacerdotisa Del Agua'),
('Vol'),
('Cazador De Demonios'),
('Dinamica');


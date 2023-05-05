BEGIN;
CREATE SEQUENCE id_socios_count;
CREATE SEQUENCE id_pedidos_count;
CREATE SEQUENCE id_detalles_count;
CREATE SEQUENCE id_libro_count;
CREATE SEQUENCE id_coleccion_count;
CREATE SEQUENCE id_almacen_count;
CREATE SEQUENCE id_provincia_count;
CREATE SEQUENCE id_poblacion_count;
CREATE SEQUENCE id_libroalmacen_count;

CREATE TABLE if not exists socio(
	id_socio int DEFAULT nextval('id_socios_count'),
	id_avalista int not NULL,
	id_poblacion int not NULL,
	dni character varying(60) not NULL,
	nombre character varying(60) not NULL,
	apellidos character varying(60)not NULL,
	telefono character varying(60)not NULL,
	CONSTRAINT pk_socio primary key (id_socio)
);

CREATE TABLE if not exists pedido(
	id_pedido int DEFAULT nextval('id_pedidos_count'),
	id_socio int not NULL,
	dni character varying(60) not NULL,
	f_pago character varying(60) not NULL,
	f_envio character varying(60)not NULL,
	CONSTRAINT pk_pedido primary key (id_pedido,id_socio)
);

CREATE TABLE if not exists detalle(
	id_detalle int DEFAULT nextval('id_detalles_count'),
	id_pedido int not NULL,
	id_socio int not NULL,
	isbn int not NULL,
	cantidad int not NULL,
	CONSTRAINT pk_detalle primary key (id_pedido)
);

CREATE TABLE if not exists libro(
	isbn int DEFAULT nextval('id_libro_count'),
	id_coleccion int not NULL,
	titulo character varying(60) not NULL,
	autor character varying(60) not NULL,
	editorial character varying(60) not NULL,
	CONSTRAINT pk_libro primary key (isbn)
);

CREATE TABLE if not exists coleccion(
	id_coleccion int DEFAULT nextval('id_almacen_count'),
	cantidad int not NULL,
	CONSTRAINT pk_coleccion primary key (id_coleccion)
);

CREATE TABLE if not exists almacen(
	id_almacen int DEFAULT nextval('id_almacen_count'),
	id_provincia int not NULL,
	CONSTRAINT pk_almacen primary key (id_almacen)
);

CREATE TABLE if not exists libroAlmacen(
	id_libroAlmacen int DEFAULT nextval('id_libroalmacen_count'),
	id_libro int not NULL,
	id_almacen int not NULL,
	cantidad int not NULL,
	CONSTRAINT pk_libroAlmacen primary key (id_libroAlmacen)
);

CREATE TABLE if not exists provincia(
	id_provincia int DEFAULT nextval('id_provincia_count'),
	id_almacen int not NULL,
	habitantes int not NULL,
	CONSTRAINT pk_provincia primary key (id_provincia)
);

CREATE TABLE if not exists poblacion(
	id_poblacion int DEFAULT nextval('id_poblacion_count'),
	id_provincia int not NULL,
	habitantes int not NULL,
	CONSTRAINT pk_poblacion primary key (id_poblacion)
);

ALTER TABLE IF EXISTS socio
    ADD CONSTRAINT fk_avalista FOREIGN KEY (id_avalista)
    REFERENCES socio (id_socio) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID,
	ADD CONSTRAINT fk_poblacion FOREIGN KEY (id_poblacion)
    REFERENCES poblacion (id_poblacion) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

ALTER TABLE IF EXISTS pedido
    ADD CONSTRAINT fk_socio FOREIGN KEY (id_socio)
    REFERENCES socio (id_socio) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
ALTER TABLE IF EXISTS detalle
    ADD CONSTRAINT fk_pedido FOREIGN KEY (id_pedido,id_socio)
    REFERENCES pedido (id_pedido,id_socio) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID,
	ADD CONSTRAINT fk_libro FOREIGN KEY (isbn)
    REFERENCES libro (isbn) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
	
ALTER TABLE IF EXISTS libro
	ADD CONSTRAINT fk_coleccion FOREIGN KEY (id_coleccion)
    REFERENCES coleccion (id_coleccion) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
	
ALTER TABLE IF EXISTS almacen
	ADD CONSTRAINT fk_provincia FOREIGN KEY (id_provincia)
    REFERENCES provincia (id_provincia) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
	
ALTER TABLE IF EXISTS libroalmacen
	ADD CONSTRAINT fk_almacen FOREIGN KEY (id_almacen)
    REFERENCES almacen (id_almacen) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
	NOT VALID,
	ADD CONSTRAINT fk_libro FOREIGN KEY (id_libro)
    REFERENCES libro (isbn) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
	NOT VALID;
ALTER TABLE IF EXISTS provincia
	ADD CONSTRAINT fk_almacen FOREIGN KEY (id_almacen)
    REFERENCES almacen (id_almacen) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;
ALTER TABLE IF EXISTS poblacion
	ADD CONSTRAINT fk_provincia FOREIGN KEY (id_provincia)
    REFERENCES provincia (id_provincia) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE
    NOT VALID;

END;



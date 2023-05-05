CREATE SEQUENCE id_zoo_count;
CREATE SEQUENCE id_especie_count;
CREATE SEQUENCE id_ejemplar_count;
CREATE TABLE zoo(
	id_zoo int DEFAULT nextval('id_zoo_count'),
	nombre character varying(60) not NULL,
	cuidad character varying(60) not NULL,
	pais character varying(60)not NULL,
	area character varying(60) not NULL,
	presupuesto int not NULL,
	CONSTRAINT pk_zoo primary key (id_zoo)
);

CREATE TABLE especie(
	id_especie int DEFAULT nextval('id_especie_count'),
	n_vulgar character varying(60) not NULL,
	n_cientifico character varying(60) not NULL,
	familia character varying(60)not NULL,
	peligro_e boolean not NULL,
	CONSTRAINT pk_especie primary key (id_especie)
);

CREATE TABLE ejemplar(
	id_ejemplar int DEFAULT nextval('id_ejemplar_count'),
	id_especie int not NULL,
	id_zoo int not NULL,
	pais character varying(60) not NULL,
	a_nacimiento int not NULL,
	continente character varying(60) not NULL,
	sexo character varying(2) not NULL,
	CONSTRAINT pk_ejemplar primary key (id_ejemplar),
	CONSTRAINT fk_zoo FOREIGN KEY(id_zoo)
	REFERENCES zoo(id_zoo)
	ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_especie FOREIGN KEY(id_especie)
	REFERENCES especie(id_especie)
	ON UPDATE CASCADE ON DELETE CASCADE
);

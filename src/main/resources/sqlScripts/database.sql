drop database db_trips;

create database db_trips;

use db_trips;

create table Usuario (
	id bigint(10) primary key not null auto_increment,
    nombre varchar(50),
    contrasena varchar(50)
);

create table Permiso (
	id bigint(10) primary key not null auto_increment,
    idUsuario bigint(10) not null,
    permiso bigint(10) not null
);

create table Ciudad (
	id bigint(10) primary key not null auto_increment,
    nombre varchar(50) not null,
    pais varchar(50) not null,
    latitud float not null,
    longitud float not null,
    imagen mediumblob,
    borrado tinyint default 0 not null
);

create table Atraccion (
	id bigint(10) primary key not null auto_increment,
    idCiudad bigint(10) not null,
    nombre varchar(50) not null,
    latitud float not null,
    longitud float not null,
    borrado tinyint default 0 not null,
    plano mediumblob,
    video mediumblob,
    recorrible tinyint default 0,
    foreign key (idCiudad) references Ciudad (id)
);

create table AtraccionIdioma (
	id bigint(10) primary key not null auto_increment,
    idAtraccion bigint(10) not null,
	idioma varchar(3) not null,
    horario varchar(100),
    descripcion varchar(250),
    borrado tinyint default 0 not null,
    precio varchar(100),
    audio mediumblob,
    foreign key (idAtraccion) references Atraccion (id)
);

create table ImagenAtraccion (
	id bigint(10) primary key not null auto_increment,
    imagen mediumblob not null,
    idAtraccion bigint(10) not null,
    foreign key (idAtraccion) references Atraccion (id)
);

create table PuntoDeInteres (
	id bigint(10) primary key not null auto_increment,
    nombre varchar(50),
    borrado tinyint default 0 not null,
    imagen mediumblob,
    idAtraccion bigint(10),
    foreign key (idAtraccion) references Atraccion (id)
);

create table PuntoIdioma (
	id bigint(10) primary key not null auto_increment,
    idioma varchar(3) not null,
    descripcion varchar(250),
    orden tinyint,
    borrado tinyint default 0 not null,
    audio mediumblob,
    idPunto bigint(10),
    foreign key (idPunto) references PuntoDeInteres (id)
);

create table Resenia (
	id bigint(10) primary key not null auto_increment,
    idUsuario bigint(10),
    foreign key (idUsuario) references Usuario (id),
	nombreUsuario varchar(50), /* Cuando esté la BDD de Usuario, se podría sacar del idUsuario */
	fecha varchar(10), /* DD-MM-AAAA */
	hora varchar(5), /* HH:MM */
    comentario varchar(250),
    calificacion float,
    borrado tinyint default 0 not null,
    idAtraccion bigint(10) not null,
    foreign key (idAtraccion) references Atraccion (id)
);

create table Recorrido (
	id bigint(10) primary key not null auto_increment,
    nombre varchar(50),
    borrado tinyint default 0 not null,
    atracciones_ordenadas varchar(1000),
    idCiudad bigint(10) not null,
    foreign key (idCiudad) references Ciudad (id)
);

create table RecorridoIdioma (
	id bigint(10) primary key not null auto_increment,
    idioma varchar(3) not null,
    descripcion varchar(250),
    borrado tinyint default 0 not null,
    audio mediumblob,
    idRecorrido bigint(10),
    foreign key (idRecorrido) references Recorrido (id)
);

create table RecorridoAtraccion (
	id bigint(10) primary key not null auto_increment,
	idAtraccion bigint(10) not null,
    idRecorrido bigint(10) not null,
    foreign key (idAtraccion) references Atraccion (id),
    foreign key (idRecorrido) references Recorrido (id)
)
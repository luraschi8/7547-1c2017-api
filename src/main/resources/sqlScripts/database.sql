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
	nombre varchar(50) not null,
    idCiudad bigint(10) not null,
    horario varchar(50),
    descripcion varchar(250),
    precio varchar(50),
    latitud float not null,
    longitud float not null,
    borrado tinyint default 0 not null,
    plano mediumblob,
    audioEN varchar(100),
    audioES varchar(100),
    video varchar(100),
    recorrible tinyint default 0,
    foreign key (idCiudad) references Ciudad (id)
);

create table ImagenAtraccion (
	id bigint(10) primary key not null auto_increment,
    imagen mediumblob not null,
    idAtraccion bigint(10) not null,
    foreign key (idAtraccion) references Atraccion (id)
);

create table PuntoInteres (
	id bigint(10) primary key not null auto_increment,
    nombre varchar(50),
    imagen mediumblob,
    idAtraccion bigint(10),
    foreign key (idAtraccion) references Atraccion (id)
)	

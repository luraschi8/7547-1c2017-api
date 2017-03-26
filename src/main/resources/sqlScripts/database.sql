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
    imagen mediumblob
);

create table Atraccion (
	id bigint(10) primary key not null auto_increment,
	nombre varchar(50) not null,
    idCiudad bigint(10) not null,
    horarioVisitaComienzo time,
    horarioVisitaFin time,
    precio float,
    latitud float not null,
    longitud float not null,
    foreign key (idCiudad) references Ciudad (id)
);

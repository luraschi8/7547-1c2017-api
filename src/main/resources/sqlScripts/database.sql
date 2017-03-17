drop database db_trips;

create database db_trips;

use db_trips;

create table Usuario (
	id bigint(10) primary key not null auto_increment,
    nombre varchar(50),
    contrasena varchar(50)
);

create table Ciudad (
	id bigint(10) primary key not null auto_increment,
    nombre varchar(50),
    pais varchar(50),
    latitud float,
    longitud float
);

create table Atraccion (
	id bigint(10) primary key not null auto_increment,
	nombre varchar(50) not null,
    idCiudad bigint(10) not null,
    horarioVisitaComienzo time,
    horarioVisitaFin time,
    precio float,
    latitud float,
    longitud float,
    foreign key (idCiudad) references Ciudad (id)
);

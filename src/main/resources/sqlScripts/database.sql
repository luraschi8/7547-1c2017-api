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
    horario varchar(100),
    descripcion varchar(250),
    precio varchar(100),
    latitud float not null,
    longitud float not null,
    borrado tinyint default 0 not null,
    plano mediumblob,
    audioEN mediumblob,
    audioES mediumblob,
    video mediumblob,
    recorrible tinyint default 0,
    foreign key (idCiudad) references Ciudad (id)
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
    descripcion varchar(250),
    orden tinyint,
    borrado tinyint default 0 not null,
    imagen mediumblob,
    audioEN mediumblob,
    audioES mediumblob,
    idAtraccion bigint(10) not null,
    foreign key (idAtraccion) references Atraccion (id)
);

create table Resenia (
	id bigint(10) primary key not null auto_increment,
    idUsuario bigint(10) not null,
    foreign key (idUsuario) references Usuario (id),
	nombreUsuario varchar(50), /* Cuando esté la BDD de Usuario, se podría sacar del idUsuario */
	fecha varchar(10), /* DD-MM-AAAA */
	hora varchar(5), /* HH:MM */
    comentario varchar(250),
    calificacion double,
    borrado tinyint default 0 not null,
    idAtraccion bigint(10) not null,
    foreign key (idAtraccion) references Atraccion (id)
);
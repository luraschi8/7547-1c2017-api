-- Database: ddvfs68eo6l9vk

drop table Usuario;
drop table Permiso;
drop table ImagenAtraccion;
drop table PuntoDeInteres;
drop table Atraccion;
drop table Ciudad;

create table Usuario (
	id serial primary key not null,
    nombre varchar(50),
    contrasena varchar(50)
);

create table Permiso (
	id serial primary key not null,
    idUsuario bigint not null,
    permiso bigint not null
);

create table Ciudad (
	id serial primary key not null,
    nombre varchar(50) not null,
    pais varchar(50) not null,
    latitud float not null,
    longitud float not null,
    imagen bytea,
    borrado int default 0 not null
);

create table Atraccion (
	id serial primary key not null,
	nombre varchar(50) not null,
    idCiudad bigint not null,
    horario varchar(100),
    descripcion varchar(250),
    precio varchar(100),
    latitud float not null,
    longitud float not null,
    borrado int default 0 not null,
    plano bytea,
    audioEN bytea,
    audioES bytea,
    video bytea,
    recorrible int default 0,
    idioma varchar(2),
    foreign key (idCiudad) references Ciudad (id)
);

create table ImagenAtraccion (
	id serial primary key not null,
    imagen bytea not null,
    idAtraccion bigint not null,
    foreign key (idAtraccion) references Atraccion (id)
);

create table PuntoDeInteres (
	id serial primary key not null,
    nombre varchar(50),
    descripcion varchar(250),
    orden int,
    borrado int default 0 not null,
    imagen bytea,
    audioEN bytea,
    audioES bytea,
    idAtraccion bigint,
    idioma varchar(2),
    foreign key (idAtraccion) references Atraccion (id)
);

create table Resenia (
	id serial primary key not null,
    idUsuario bigint not null,
    foreign key (idUsuario) references Usuario (id),
	nombreUsuario varchar(50), /* Cuando esté la BDD de Usuario, se podría sacar del idUsuario */
	fecha varchar(10), /* DD-MM-AAAA */
	hora varchar(5), /* HH:MM */
    comentario varchar(250),
    borrado int default 0 not null,
    calificacion double,
    foreign key (idAtraccion) references Atraccion (id)
);

create table Recorrido (
	id serial primary key not null,
    nombre varchar(50),
    descripcion varchar(250),
    borrado int default 0 not null,
    idioma varchar(2),
    idCiudad bigint not null,
    foreign key (idCiudad) references Ciudad (id)
);
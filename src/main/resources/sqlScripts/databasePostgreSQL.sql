-- Database: ddvfs68eo6l9vk

drop table Permiso;
drop table ImagenAtraccion;
drop table PuntoIdioma;
drop table PuntoDeInteres;
drop table Resenia;
drop table Usuario;
drop table AtraccionIdioma;
drop table Atraccion;
drop table RecorridoIdioma;
drop table RecorridoAtraccion;
drop table Recorrido;
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
    latitud float not null,
    longitud float not null,
    borrado int default 0 not null,
    plano bytea,
    video bytea,
    recorrible int default 0,
    foreign key (idCiudad) references Ciudad (id)
);

create table AtraccionIdioma (
	id serial primary key not null,
    idAtraccion bigint not null,
	idioma varchar(3) not null,
    horario varchar(100),
    descripcion varchar(250),
    borrado int default 0 not null,
    precio varchar(100),
    audio bytea,
    foreign key (idAtraccion) references Atraccion (id)
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
    borrado int default 0 not null,
    imagen bytea,
    idAtraccion bigint,
    foreign key (idAtraccion) references Atraccion (id)
);

create table PuntoIdioma (
	id serial primary key not null,
    idioma varchar(3) not null,
    descripcion varchar(250),
    orden int,
    borrado int default 0 not null,
    audio bytea,
    idPunto bigint,
    foreign key (idPunto) references PuntoDeInteres (id)
);

create table Resenia (
	id serial primary key not null,
    idUsuario bigint,
    foreign key (idUsuario) references Usuario (id),
	nombreUsuario varchar(50), /* Cuando esté la BDD de Usuario, se podría sacar del idUsuario */
	fecha varchar(10), /* DD-MM-AAAA */
	hora varchar(5), /* HH:MM */
    comentario varchar(250),
    borrado int default 0 not null,
    calificacion real,
    idAtraccion bigint,
    foreign key (idAtraccion) references Atraccion (id)
);

create table Recorrido (
	id serial primary key not null,
    nombre varchar(50),
    borrado int default 0 not null,
    idCiudad bigint not null,
    foreign key (idCiudad) references Ciudad (id)
);

create table RecorridoIdioma (
	id serial primary key not null,
    idioma varchar(3) not null,
    descripcion varchar(250),
    borrado int default 0 not null,
    audio bytea,
    idRecorrido bigint not null,
    foreign key (idRecorrido) references Recorrido (id)
);

create table RecorridoAtraccion (
	id serial primary key not null,
	idAtraccion bigint not null,
    idRecorrido bigint not null,
    foreign key (idAtraccion) references Atraccion (id),
    foreign key (idRecorrido) references Recorrido (id)
)
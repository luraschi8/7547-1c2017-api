insert into Usuario values (1,'admin','1234');

INSERT INTO `Permiso` (`id`,`idUsuario`,`permiso`) VALUES (1,1,1);

insert into Ciudad(id,nombre,pais,latitud,longitud) values (1,'Buenos Aires','Argentina',34.6037,58.3816);
insert into Ciudad(id,nombre,pais,latitud,longitud) values (2,'Rosario','Argentina',34.6037,58.3816);

insert into Atraccion values (1,'Casa Rosada',1,'09:00','21:00',1,34.6010,58.3831,false);
insert into Atraccion values (2,'Obelisco',1,'09:00','21:00',1,34.6010,58.3831,false);
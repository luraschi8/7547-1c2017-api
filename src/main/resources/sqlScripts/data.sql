insert into Usuario values (1,'admin','1234');

INSERT INTO `Permiso` (`id`,`idUsuario`,`permiso`) VALUES (1,1,1);

insert into Ciudad(id,nombre,pais,latitud,longitud) values (1,'Buenos Aires','Argentina',-34.6036844,-58.3815591);
insert into Ciudad(id,nombre,pais,latitud,longitud) values (2,'Rosario','Argentina',-32.9442426,-60.6505388);

insert into Atraccion values (1,'Casa Rosada',1,'09:00','21:00',1,-34.6080556,-58.3702778,false);
insert into Atraccion values (2,'Obelisco',1,'09:00','21:00',1,-34.6037389,-58.3815704,false);
insert into Atraccion values (3,'Malba',1,'09:00','21:00',1,-34.5771111,-58.4035933,false);
insert into Atraccion values (4,'Monumeto a la bandera',2,'09:00','21:00',1,-32.9477132,-60.6304658,false);
/*insert into Usuario values (1,'admin','1234');

INSERT INTO `Permiso` (`id`,`idUsuario`,`permiso`) VALUES (1,1,1);

insert into Ciudad(id,nombre,pais,latitud,longitud,imagen) values (1,'Buenos Aires','Argentina',-34.6036844,-58.3815591,LOAD_FILE('C:\Windows\Web\Wallpaper\Theme1\img1.jpg'));
insert into Ciudad(id,nombre,pais,latitud,longitud,imagen) values (2,'Rosario','Argentina',-32.9442426,-60.6505388,LOAD_FILE('C:\Windows\Web\Wallpaper\Theme1\img2.jpg'));

insert into Atraccion(id,nombre,idCiudad,horario,descripcion,precio,latitud,longitud,borrado) values 
					(1,'Casa Rosada',1,'Un horario magico','Es rrrosa!','Gratis',-34.6080556,-58.3702778,0);
insert into Atraccion(id,nombre,idCiudad,horario,descripcion,precio,latitud,longitud,borrado) values 
					(20,'Obelisco',1,'Show time','ESS blanco..?','Afano total'-34.6037389,-58.3815704,0);*/
					
	

insert into Usuario(id,nombre,contrasena) values 
					(1,'José Núñez','password');
insert into Usuario(id,nombre,contrasena) values 
					(2,'Juan Pérez','password');
					
insert into Resenia(id,idUsuario,nombreUsuario,fecha,hora,comentario,calificacion,borrado,idAtraccion) values 
					(1,1,'José Núñez','22/04/2017','10:10','Excelente atracción!',5.0,0,1);
insert into Resenia(id,idUsuario,nombreUsuario,fecha,hora,comentario,calificacion,borrado,idAtraccion) values 
					(2,2,'Juan Pérez','23/04/2017','15:24','Me pareció aburrido',2.0,0,1);
					
insert into Resenia(id,idUsuario,nombreUsuario,fecha,hora,comentario,calificacion,borrado,idAtraccion) values 
					(3,2,'Juan Pérez','23/04/2017','15:26','No me gustó',2.0,0,1);
                    
                    
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9123','pepe@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9124','pepe1@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (2,'9125','pepe2@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (3,'9126','pepe3@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9127','pepe4@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (2,'9128','pepe5@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (3,'9129','pepe6@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (2,'9120','pepe7@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (2,'9120','pepe7@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9120','pepe7@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9120','pepe7@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (3,'9120','pepe7@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (3,'9120','pepe7@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9120','pepe7@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (2,'9120','pepe7@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9120','pepe7@gmail.com','01/01/2017');

insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9120',null,'01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9120',null,'01/01/2017');


insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9123','pepe@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9123','pepe2@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9125','pepe@gmail.com','01/01/2017');
insert into VisitaAtraccion(idAtraccion,idAndroid,idRedSocial,fecha) values (1,'9125',null,'01/01/2017');

/*insert into Usuario(id, nombre, idAndroid, idRedSocial, pais, ultimaFechaConexion) values 
					(1, 'Jose Gomez', '1111', 'josegomez@gmail.com', 'Argentina', '2017/05/22');
insert into Usuario(id, nombre, idAndroid, idRedSocial, pais, ultimaFechaConexion) values 
					(2, 'Juan Perez', '2222', 'juanperez@gmail.com', 'Argentina', '2017/05/25');
insert into Usuario(id, nombre, idAndroid, idRedSocial, pais, ultimaFechaConexion) values 
					(3, 'Alberto Gonzalez', '3333', 'albertogonzalez@gmail.com', 'Brasil', '2017/05/20');
insert into Usuario(id, nombre, idAndroid, idRedSocial, pais, ultimaFechaConexion) values 
					(4, 'Julio Sosa', '4444', 'juliososa@gmail.com', 'Uruguay', '2017/05/27');
insert into Usuario(id, nombre, idAndroid, idRedSocial, pais, ultimaFechaConexion) values 
					(5, 'Jose Gomez', '5555', null, 'Argentina', '2017/05/23');
insert into Usuario(id, nombre, idAndroid, idRedSocial, pais, ultimaFechaConexion) values 
					(6, 'Luciana Alvarez', '6666', 'lucianaalvarez@gmail.com', 'Argentina', '2017/05/26');
insert into Usuario(id, nombre, idAndroid, idRedSocial, pais, ultimaFechaConexion) values 
					(7, 'Juana Martinez', '7777', null, 'Brasil', '2017/05/26');
insert into Usuario(id, nombre, idAndroid, idRedSocial, pais, ultimaFechaConexion) values 
					(8, 'Pablo Perez', '8888', 'pabloperez@gmail.com', 'Uruguay', '2017/05/27');*/
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
# 7547-1c2017-api
Taller de desarrollo de proyectos 1c. 2017 Api


Para correrlo, en src/main/resources cambien el databsae properties con su contraseña y password y corran el script de database en sqlScripts.

Si estan en eclipse: File -> Import -> Existing Maven Project

Local server lo estoy corriendo en Tomcat 7

MYSQL -- max_allowed packet

En Windows -> C:\ProgramData\MYSQL\MySQL Server\

Editar archivo my.ini en modo Administrador -> Cambiar max_allowed_packet=4M por un valor mas alto (EJ: max_allowed_packet=500M) 

Abrir consola y correr comandos : 

net stop MySQL   
net start MySQL

Si no funciona, poner version: 

net stop MySQL57   
net start MySQL57

Si no, a googlear... (?)

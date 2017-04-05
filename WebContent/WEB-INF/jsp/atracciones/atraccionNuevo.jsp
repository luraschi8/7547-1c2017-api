<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="../template/importacion.jsp"></jsp:include>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Trips - Nueva atracción</title>
	</head>
	
	<body>
		<h1 class="page-header">Nueva atracción</h1>
		
		
		
		<form:form class="form-horizontal maxwid" id ="formNuevo" name="formNuevo" action="atraccionNuevoValidar" method="post" commandName="atraccion" enctype="multipart/form-data">
			<div  class="atraction-new-form"> 
				<div class="atraction-main-information-and-map" style="width: 100%; overflow: hidden;">	
					<div class="atraction-main-information" style="float:left">
						<div>
							<form:label class="atraction-label atraction-name-label" path="nombre">Nombre</form:label>
						</div>
						<div>
						    <form:input id="atraction-name" class="atraction-box atraction-name-box" type="text" path="nombre" required="required" placeholder="Ingrese el nombre de la atracción"/>
						</div>
						
						<div>
							<form:label class="atraction-label atraction-description-label" path="descripcion">Descripción</form:label>
						</div>
						<div>
						    <form:input id="atraction-description" class="atraction-box atraction-description-box" type="text" path="descripcion" required="required" placeholder="Ingrese la descripción de la atracción"/>
						</div>
						
						<div>
							<form:label class="atraction-label atraction-schedule-label" path="horario">Horario</form:label>
						</div>
						<div>
							<form:input id="atraction-schedule" class="atraction-box atraction-schedule-box" type="text" path="horario" placeholder="Ingrese el horario de visita de la atracción"/>
						</div>
						
						<div>
							<form:label class="atraction-label atraction-cost-label" path="precio">Precio</form:label>
						</div>
						<div>
							<form:input id="atraction-cost" class="atraction-box atraction-cost-box" type="text" path="precio" placeholder="Ingrese el costo de la atracción"/>
						</div>
						
					</div>  
				</div>
				
				<div class="atraction-blueprints-group" style="width:100%; height:100%; overflow: auto;">
					<div class="atraction-blueprints-box" style="float:left" id="zonaArrastrable">
						<img id="atraction-blueprints" style="width:100%; height:100%">
						<input type="button" id="atraction-get-blueprints" class="btn btn-default atraction-get-blueprints" value="Editar">
					</div>
	
					
					<div class="alert-message">
						<div class="alert alert-warning fade in" id="mensajeImagenIncorrectaError" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>Error!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otra.
						</div>
						
						<div class="alert alert-warning fade in" id="mensajeNombreRepetido" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>Error!</strong> La atracción seleccionada ya se encuentra registrada, seleccione otra.
						</div>
						
						<div class="alert alert-warning fade in" id="mensajeNombreVacio" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>Error!</strong> No se ha seleccionado un nombre para la atracción.
						</div>
					</div>
				</div>
			</div>
		</form:form>
		
		<div class="btn-final" style="text-align:center;">
			<input id="botonAtras" class="btn btn-default" type="button" value="Cancelar" />
			<input id="botonNuevo" class="btn btn-default" type="button" value="Guardar" />
		</div>
		
		
		
		
		
        <!--
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places&callback=initMap" async defer></script>
        -->
	</body>
</html>
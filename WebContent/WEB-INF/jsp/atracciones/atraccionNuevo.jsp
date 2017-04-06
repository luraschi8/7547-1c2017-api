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
	<title>Trips - Nueva atracci�n</title>
</head>
	
<body>
	<h1 class="page-header">Nueva atracci�n</h1>
	
	<form:form class="form-horizontal maxwid" id ="formNuevo" name="formNuevo" action="atraccionNuevoValidar" method="post" commandName="atraccion" enctype="multipart/form-data">
	<div  class="atraction-new-form"> 
		<div class="atraction-main-information-and-map" style="width: 100%; overflow: hidden;">	
			<div class="atraction-main-information" style="float:left">
				<input type="hidden" id="idCiudad" name="idCiudad" value="${atraccion.ciudad.id}"/>
				
				<div>
					<form:label class="atraction-label atraction-name-label" path="nombre">Nombre</form:label>
				</div>
				<div>
				    <form:input id="nombre" class="atraction-box atraction-name-box" type="text" path="nombre" required="required" placeholder="Ingrese el nombre de la atracci�n"/>
				</div>
				
				<div>
					<form:label class="atraction-label atraction-description-label" path="descripcion">Descripci�n</form:label>
				</div>
				<div>
				    <form:input id="descripcion" class="atraction-box atraction-description-box" type="text" path="descripcion" required="required" placeholder="Ingrese la descripci�n de la atracci�n"/>
				</div>
				
				<div>
					<form:label class="atraction-label atraction-schedule-label" path="horario">Horario</form:label>
				</div>
				<div>
					<form:input id="horario" class="atraction-box atraction-schedule-box" type="text" path="horario" placeholder="Ingrese el horario de visita de la atracci�n"/>
				</div>
				
				<div>
					<form:label class="atraction-label atraction-cost-label" path="precio">Precio</form:label>
				</div>
				<div>
					<form:input id="precio" class="atraction-box atraction-cost-box" type="text" path="precio" placeholder="Ingrese el costo de la atracci�n"/>
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
				 	<strong>Error!</strong> La atracci�n seleccionada ya se encuentra registrada, seleccione otra.
				</div>
				
				<div class="alert alert-warning fade in" id="mensajeNombreVacio" style="display: none;">
				 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>Error!</strong> No se ha seleccionado un nombre para la atracci�n.
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
<script>

$('#botonNuevo').on('click', function(e) {
		e.preventDefault();
		document.getElementById("mensajeNombreRepetido").style.display = 'none';
 	 	validarAtraccionRepetida();
});

function validarAtraccionRepetida() {
	hayError = 0;
	if (document.getElementById('nombre').value == '') {
		document.getElementById("mensajeNombreVacio").style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById("mensajeNombreVacio").style.display = 'none';
	}
	if (hayError == 1) {
		return;
	} 
	var json = {
		"nombre" : document.formNuevo.nombre.value,
		"idCiudad": document.formNuevo.idCiudad.value,
	};
	$.ajax({
		url : "validarAtraccion",
		type : "POST",
		data : JSON.stringify(json),
		processData : false,
		dataType: "json",
		contentType : "application/json",
		success: function (data) {
			if (data.existe == false) {
				document.getElementById("formNuevo").submit();
			} else {
				document.getElementById("mensajeNombreRepetido").style.display = 'block';
			}
		}
	});
}

</script>
</body>
</html>
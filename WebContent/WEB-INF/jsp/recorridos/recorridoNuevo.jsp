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
<title>Trips - Nuevo recorrido</title>
</head>
<body>
	<h1 class="page-header" style="width: 94%; margin-left: 3%; margin-right: 3%">Nuevo recorrido</h1>
	
	<div id="routeForm" style="width: 94%; margin-left: 3%; margin-right: 3%">
		<form:form id="formNuevo" name="formNuevo" action="recorridoNuevoValidar" method="post" commandName="recorrido" enctype="multipart/form-data">
		
		<div class="route_new_form" style="display: inline-block; overflow: hidden;">
			
			<div class="route_main_information_and_map" style="width: 100%; margin_bottom: 75%;">
				<!-- Bloque izquierdo -->
				<div class="route_left_block" style="float:left; margin-top: -1%">
	
					<!-- Información principal -->
					<div class="route_main_information">
						<input type="hidden" id="idCiudad" name="idCiudad" value="${recorrido.ciudad.id}"/>
						<input type="hidden" id="id" name="id" value="${recorrido.id}"/>
	
						<div class="route_language">
							<form:label class="atraction-label atraction-language-label" path="idioma">Seleccione el idioma</form:label>
						  	<div>
							  	<input type="radio" id="lang_es" name="idioma" path="idioma" value="es" style="margin: 4px" checked="checked">Español
							  	<input type="radio" id="lang_en" name="idioma" path="idioma" value="en" style="margin: 4px; margin-left: 15px;">Inglés
							</div>
						</div>
						
						<div class="route_name" style="margin-top: 1%">
							<form:label class="route_name_label" path="nombre">Nombre</form:label>
						</div>
						<div>
							<textarea onkeydown="calculateMaxLength('#nombre', MAX_NOMBRE_RECORRIDO)" rows="1" id="nombre" path="nombre" name="nombre" class="route_box" placeholder="Ingrese el nombre del recorrido" required></textarea>
						</div>
						
						<div class="alert alert-danger fade in atraction-alert" id="mensajeNombreVacio" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado un nombre para el recorrido.
						</div>
						
						<div class="route_description" style="margin-top: 1%">
							<form:label class="route_description_label" path="descripcion">Descripción</form:label>
						</div>
						<div>
							<textarea onkeydown="calculateMaxLength('#descripcion', MAX_DESCRIPCION_RECORRIDO)" rows="4" id="descripcion" path="descripcion" name="descripcion" class="route_box"  placeholder="Ingrese la descripcion del recorrido" required></textarea>
						</div>
						
						<div class="alert alert-danger fade in atraction-alert" id="mensajeDescripcionVacia" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado una descripción para la atracción.
						</div>
					</div>
				</div>
				
				<!-- Bloque derecho -->
				<div class="route_right_block" style="float: right">
					<!-- Mapa -->
					<div id="route_map_group">
						<div id="view_or_edit_route_map" class="view_or_edit_route_map"></div>
						
						<div class="alert alert-danger fade in error_msg_new_route_no_atraction" id="mensajeNingunaAtraccionElegida" style="display: none">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado ninguna atracción para el recorrido. Debe poseer al menos una.
						</div>
					</div>
				</div>
			</div>
			
			<div class="route_tables" style="width: 100%;">
				<div class="route_left_block" style="clear: both; float: left; width: 48%; margin-top: 2%;">
					<label>Atracciones de la ciudad</label>
					<div style="width: 100%;" class="panel panel-primary route-panel">
						<div class="panel-body route_panel_body">
							<table id="table_all_atractions" class="display order-column route_board" cellspacing="0">
								<thead>
									<tr>
										<th></th> <!-- Imagen -->
										<th></th> <!-- Nombre -->
										<th></th> <!-- Agregar -->
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
				
				<div class="route_right_block" style="float: right; width: 48%; margin-top: 2%;">
					<label>Atracciones del recorrido</label>
					<div style="width: 100%;" class="panel panel-primary route-panel">
						<div class="panel-body route_panel_body">
							<table id="table_route_atractions" class="display order-column route_board" cellspacing="0">
								<thead>
									<tr>
										<th></th> <!-- Quitar -->
										<th></th> <!-- Orden -->
										<th></th> <!-- Imagen -->
										<!--<th></th>--> <!-- Nombre -->
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<div class="alert alert-danger fade in error_msg_route_already_exists" id="mensajeNombreRepetido" style="display: none;">
		 	<a class="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>&iexclError!</strong>El recorrido seleccionado ya se encuentra registrado. Seleccione otro nombre.
		</div>
		
		</form:form>
	</div>
	
	<form:form id="formAtras" action="ciudadVer?idCiudad=${recorrido.ciudad.id}" method="post"></form:form>
	<div class="btn-final" style="text-align:center;">
		<input id="botonAtras" class="btn btn-default" type="button" value="Cancelar" />
		<input id="botonNuevo" class="btn btn-default btn-primary" type="button" value="Guardar" />
	</div>


<!-- Definición de constantes -->
<script>
const MAX_NOMBRE_RECORRIDO = "50";
const MAX_DESCRIPCION_RECORRIDO = "250";

$("#nombre").attr("maxlength", MAX_NOMBRE_RECORRIDO);
$("#descripcion").attr("maxlength", MAX_DESCRIPCION_RECORRIDO);
</script>

<script>
var table_all_atractions = $('#table_all_atractions').DataTable( {
	dom: 'frtip',
	ajax: "atraccionesCiudadJson/${recorrido.ciudad.id}",
    columns: [
        {	data: "id",
        	render: function (data,type,row) {
        		return '<div align="center"><img src="${pageContext.request.contextPath}/imagenPrincipalAtraccion?id=' + data + '" style="align: center; width:40px; height:40px"/></div'
        	}
        },
        {data: "nombre" },
        {defaultContent:'<button class="btn btn-success" id="add_atraction"> > </button>'}
        ],
    select:true,
    paging:false,
    pageLength:50,
    ordering:true,
    bFilter: false
});

var table_all_atractions = $('#table_route_atractions').DataTable( {
	dom: 'frtip',
	ajax: "atraccionesCiudadJson/${recorrido.ciudad.id}",
    columns: [
    	{defaultContent:'<button class="btn btn-danger" id="add_atraction"> < </button>'},
        {	data: "id",
        	render: function (data,type,row) {
        		return '<div align="center"><img src="${pageContext.request.contextPath}/imagenPrincipalAtraccion?id=' + data + '" style="align: center; width:40px; height:40px"/></div'
        	}
        },
        {data: "nombre"}
        ],
    select:true,
    paging:false,
    pageLength:50,
    ordering:true,
    bFilter: false
});








$('#botonAtras').on('click', function(e) {
	e.preventDefault();
	document.getElementById("formAtras").submit();
});

$('#botonNuevo').on('click', function(e) {
	e.preventDefault();
	document.getElementById("mensajeNombreRepetido").style.display = 'none';
	hideAllRouteErrorMessages();
 	validarRecorridoRepetido();
});

function validarElemento(elemento, mensaje, hayError) {
	if ((document.getElementById(elemento).value == '') && (!hayError)) {
		document.getElementById(mensaje).style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById(mensaje).style.display = 'none';
	}
	return hayError;
}

function validarUbicacion(hay_ubicacion, mensaje, hayError) {
	if ((!hay_ubicacion) && (!hayError)) {
		document.getElementById(mensaje).style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById(mensaje).style.display = 'none';
	}
	return hayError;
}

//Para validar si se ha o no elegido una ubicación
var location_selected = false;

function validarRecorridoRepetido() {
	hideAllAtractionErrorMessages();
	hayError = 0;
	hayError = validarElemento('nombre', 'mensajeNombreVacio', hayError);
	hayError = validarElemento('descripcion', 'mensajeDescripcionVacia', hayError);
	hayError = validarUbicacion(location_selected, "mensajeUbicacionVacia", hayError);
	
	if (hayError == 1) {
		return;
	}
	
	var ciudad = {
		"id": document.formNuevo.idCiudad.value,
	}
	
	var json = {
		"ciudad": ciudad,
		"nombre": document.formNuevo.nombre.value,
	};
	
	$.ajax({
		url : "validarRecorrido",
		type : "POST",
		data : JSON.stringify(json),
		processData : false,
		dataType: "json",
		contentType : "application/json",
		success: function (data) {
			if (data.existe == false) {
				document.formNuevo.recorrible.value = $("input[name='idioma']:checked").val();
			  	document.getElementById("formNuevo").submit();
			} else {
				document.getElementById("mensajeNombreRepetido").style.display = 'block';
			}
		}
	});
}
</script>

<c:set var="latitud_ciudad">
	${recorrido.ciudad.latitud}
</c:set>

<c:set var="longitud_ciudad">
	${recorrido.ciudad.longitud}
</c:set>

<script>
function initMap() {
	map = new google.maps.Map(document.getElementById('view_or_edit_route_map'), {
	    center: {lat: ${latitud_ciudad}, lng: ${longitud_ciudad}},
	    zoom: 13
	});
};
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places&callback=initMap" async defer></script>
	
</body>
</html>
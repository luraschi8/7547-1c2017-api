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
						<input type="hidden" name="atracciones" value=""/>
	
						<div class="route_language">
							<form:label class="atraction-label atraction-language-label" path="idioma">Seleccione el idioma</form:label>
						  	<div>
							  	<input type="radio" id="lang_es" name="idioma" path="idioma" value="es" style="margin: 4px" checked="checked">Español
							  	<input type="radio" id="lang_en" name="idioma" path="idioma" value="en" style="margin: 4px; margin-left: 15px;">Inglés
							</div>
						</div>
						
						<div class="route_name" style="margin-top: 1%">
							<form:label class="route_name_label" path="nombre">Nombre<font color="red"> *</font></form:label>
						</div>
						<div>
							<textarea onkeydown="calculateMaxLength('#nombre', MAX_NOMBRE_RECORRIDO)" rows="1" id="nombre" path="nombre" name="nombre" class="route_box" placeholder="Ingrese el nombre del recorrido" required></textarea>
						</div>
						
						<div class="alert alert-danger fade in route_alert" id="mensajeNombreVacio" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado un nombre para el recorrido.
						</div>
						
						<div class="route_description" style="margin-top: 1%">
							<form:label class="route_description_label" path="descripcion">Descripción<font color="red"> *</font></form:label>
						</div>
						<div>
							<textarea onkeydown="calculateMaxLength('#descripcion', MAX_DESCRIPCION_RECORRIDO)" rows="4" id="descripcion" path="descripcion" name="descripcion" class="route_box"  placeholder="Ingrese la descripcion del recorrido" required></textarea>
						</div>
						
						<div class="alert alert-danger fade in route_alert" id="mensajeDescripcionVacia" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado una descripción para la atracción.
						</div>
					</div>
					
					<!-- Audioguía -->
					<div style="width: 100%; height: 15%">
						<div style="width: 100%; height: 40%">
							<label class="atraction-label" path="audioES">Audioguía</label>
						</div>
						<input type="hidden" id="audioCambiadoRecorrido" name="audioCambiadoRecorrido" value=0>
						<div style="width: 100%; height: 60%">
							<!-- Reproducir audioguía -->
							<div style="float: left; width: 85%; height: 50%">
								<audio id="audioRecorrido" style="width: 100%;" controls>
								    <source type="audio/mpeg">
								</audio> 
							</div>
							
							<!-- Botón agregar audioguía -->
							<div style="float: right; width: 15%; height: 50%; text-align: right;">
								<button type="button" class="btn btn-default btn-sm btn-atraction-get-route-audio-file" id="getAudioRecorrido">
									<span class="glyphicon glyphicon-pencil"></span>
								 </button>
							
								<button type="button" class="btn btn-default btn-sm btn-atraction-erase-route-audio-file" id="borrarAudioRecorrido">
									<span class="glyphicon glyphicon-erase"></span>
								 </button>
						
								<input type="file" name="archivoAudioguiaRecorrido" id="archivoAudioguiaRecorrido"/>
							</div>
						</div>
					</div>
					
					<div class="alert alert-danger fade in atraction-alert-incorrect-audio" id="mensajeAudioRecorridoIncorrectoError" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo seleccionado no es un audio válido. Por favor, introduzca otro.
					</div>
					
					<div class="alert alert-danger fade in atraction-alert-incorrect-audio" id="mensajeAudioRecorridoTamano" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo pesa mas de 3MB. Por favor, seleccione uno de menor tamaño.
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
					<font color="red" size="1">Los campos indicados con * son obligatorios</font>
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
						<font color="red" size="1">&nbsp;&nbsp;&nbsp;&nbsp;* Deben añadirse al menos dos atracciones</font>
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

<script src="${pageContext.request.contextPath}/js/ownFunctions.js"></script>

<!-- Definición de constantes -->
<script>
const MAX_NOMBRE_RECORRIDO = "50";
const MAX_DESCRIPCION_RECORRIDO = "250";

$("#nombre").attr("maxlength", MAX_NOMBRE_RECORRIDO);
$("#descripcion").attr("maxlength", MAX_DESCRIPCION_RECORRIDO);
</script>

<script>
validateAudio("getAudioRecorrido", "borrarAudioRecorrido", "archivoAudioguiaRecorrido", "audioRecorrido", "audioCambiadoRecorrido", "mensajeAudioRecorridoTamano", "mensajeAudioRecorridoIncorrectoError");

var fuera_del_recorrido = new Array();
var dentro_del_recorrido = new Array();

var table_all_atractions = $('#table_all_atractions').DataTable( {
	dom: 'frtip',
	ajax: "atraccionesFueraDelRecorridoNuevoJson/${recorrido.ciudad.id}",
    columns: [
        {	data: "id",
        	render: function (data,type,row) {
        		return '<div align="center"><img src="${pageContext.request.contextPath}/imagenPrincipalAtraccion?id=' + data + '" style="align: center; width:40px; height:40px"/></div'
        	}
        },
        {data: "nombre" },
        {defaultContent:'<button class="btn btn-success" id="add_atraction"> > </button>'}
        ],
    "columnDefs": [
   		{className: "dt-body-right", "targets": [2]}
    ],
    select:true,
    paging:false,
    pageLength:30,
    ordering:true,
    bFilter: false
});

var table_route_atractions = $('#table_route_atractions').DataTable( {
	dom: 'frtip',
	ajax: "atraccionesEnElRecorridoNuevoJson/${recorrido.ciudad.id}",
    columns: [
    	{defaultContent:'<button class="btn btn-danger" id="remove_atraction"> < </button>'},
        {	data: "id",
        	render: function (data,type,row) {
        		return '<div align="center"><img src="${pageContext.request.contextPath}/imagenPrincipalAtraccion?id=' + data + '" style="align: center; width:40px; height:40px"/></div'
        	}
        },
        {data: "nombre"}
        ],
    select:true,
    paging:false,
    pageLength:30,
    ordering:true,
    bFilter: false
});

function initializeAllAtractions() {
	table_all_atractions.rows().every(function () {
	    var data = this.data();
	    fuera_del_recorrido.push(data["id"]);
	});
}

$('#table_all_atractions tbody').on('click', '#add_atraction', function (e) {
	if (fuera_del_recorrido.length == 0) {
		initializeAllAtractions();
	}
	e.preventDefault();
	var data = table_all_atractions.row(this.closest("tr")).data();
	drawAtractionInMap(data);
	dentro_del_recorrido.push(data["id"]);
	fuera_del_recorrido.splice(dentro_del_recorrido.indexOf(data["id"]), 1);
	table_route_atractions.row.add({
        "id":       data.id,
        "nombre":   data.nombre,
        "latitud":   data.latitud,
        "longitud":   data.longitud
    }).draw();
	table_all_atractions.row(this.closest("tr")).remove().draw();
});


$('#table_route_atractions tbody').on('click', '#remove_atraction', function (e) {
	e.preventDefault();
	var data = table_route_atractions.row(this.closest("tr")).data();
	drawAtractionInMap(data);
	dentro_del_recorrido.splice(dentro_del_recorrido.indexOf(data["id"]), 1);
	fuera_del_recorrido.push(data["id"]);
	table_all_atractions.row.add({
        "id":       data.id,
        "nombre":   data.nombre,
        "latitud":   data.latitud,
        "longitud":   data.longitud
    }).draw();
	table_route_atractions.row(this.closest("tr")).remove().draw();
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

function validarRecorridoRepetido() {
	hayError = 0;
	hayError = validarElemento('nombre', 'mensajeNombreVacio', hayError);
	hayError = validarElemento('descripcion', 'mensajeDescripcionVacia', hayError);
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
				document.formNuevo.idioma.value = $("input[name='idioma']:checked").val();
				var atracciones_aux = "";
				for (var i = 0; i < dentro_del_recorrido.length; i++) {
					atracciones_aux += dentro_del_recorrido[i] + ",";
				}
				document.formNuevo.atracciones.value = atracciones_aux.substring(0, atracciones_aux.length - 1);
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
var map;
var markers = [];

function initMap() {
	map = new google.maps.Map(document.getElementById('view_or_edit_route_map'), {
	    center: {lat: ${latitud_ciudad}, lng: ${longitud_ciudad}},
	    zoom: 13
	});
};

function drawAtractionInMap(data) {
	var latitud = data["latitud"];
	var longitud = data["longitud"];
	var myLatlng = new google.maps.LatLng(latitud, longitud);
	for (var i = 0; i < markers.length; i++) {
		pos = markers[i].getPosition();
		if (pos.lat() == myLatlng.lat() && pos.lng() == myLatlng.lng()) {
			markers[i].setMap(null);
			markers.splice(i, 1);
			return;
		}
	}
	var marker = new google.maps.Marker({
         position: myLatlng
    });
    
    marker.setMap(map);
	map.setCenter(marker.getPosition());
	markers.push(marker);
}
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places&callback=initMap" async defer></script>
	
</body>
</html>
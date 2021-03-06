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
<title>Trips - ${recorrido.recorrido.nombre}</title>
</head>

<body onload="setLanguage();">
	<nav class="navbar navbar-default">
	  	<div class="container-fluid">
		    <ul class="nav navbar-nav">
		      	<li class="active"><a href="ciudades">Ciudades</a></li>
		      	<li><a href="atraccionesDeMayorInteres">Reportes</a></li>
		    </ul>
	  	</div>
	</nav>
	
	<nav class="navbar navbar-default">
		<div class="container-fluid">
	    	<ul class="nav navbar-nav">
	      		<li class="dropdown" id="select_language">
	        		<a class="active dropdown-toggle" data-toggle="dropdown" href="#">Idioma
	        			<span class="caret"></span>
	        		</a>
	        		<ul class="dropdown-menu">
			          	<li onclick="setSpanish();"><a href="#">Espa�ol</a></li>
			          	<li onclick="setEnglish();"><a href="#">Ingl�s</a></li>
	        		</ul>
	      		</li>
	    	</ul>
	  	</div>
	</nav>

	<h1 class="page-header route-new-page-header" style="width: 94%; margin-left: 3%; margin-right: 3%">${recorrido.recorrido.nombre} - ${recorrido.recorrido.ciudad.nombre}</h1>
	
	<div id="routeForm" style="width: 94%; margin-left: 3%; margin-right: 3%">
		<form:form id="formModificar" name="formModificar" action="recorridoModificar" method="post" commandName="recorrido" enctype="multipart/form-data">
		
		<div class="route_new_form" style="display: inline-block; overflow: hidden;">
			
			<div class="route_main_information_and_map" style="width: 100%;">
				<!-- Bloque izquierdo -->
				<div class="route_left_block" style="float:left; margin-top: -0.5%">
	
					<!-- Informaci�n principal -->
					<div class="route_main_information">
						<input type="hidden" id="idCiudad" name="idCiudad" value="${recorrido.recorrido.ciudad.id}"/>
						<input type="hidden" id="id" name="id" value="${recorrido.id}"/>
						<input type="hidden" name="atracciones" value=""/>
						<input type="hidden" name="atraccionesCambiadas" id="atraccionesCambiadas" value="0"/>

						<div class="route_name" style="margin-top: 2%">
							<form:label class="route_name_label" path="recorrido.nombre">Nombre</form:label>
							<input type="hidden" id="nombre" name="nombre" value="${recorrido.recorrido.nombre}"/>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" id="edit-name" onclick="editField('#nombreEditado', 'ok-nombre', 'cancel-nombre', 'mensajeNombreVacio', true)">
								<span class="glyphicon glyphicon-pencil"></span>
							</button>
						</div>

						<div>
							<div>
								<p id="nombreEditado" style="white-space: pre-wrap;" class="atraction-box atraction-name-box" path="nombre" contenteditable="false" value="${recorrido.recorrido.nombre}">${recorrido.recorrido.nombre}</p>
								<textarea onkeydown="calculateMaxLength('#nombreEditadoTextarea', MAX_NOMBRE_RECORRIDO)" style="display:none" rows="1" id="nombreEditadoTextarea" class="route_box" value="${recorrido.recorrido.nombre}">${recorrido.recorrido.nombre}</textarea>
							</div>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: red;" id="cancel-nombre" onclick="cancelField('#nombreEditado', 'ok-nombre', 'cancel-nombre')">
								<span class="glyphicon glyphicon-remove"></span>
							</button>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: green;" id="ok-nombre" onclick="saveField('#nombreEditado', 'ok-nombre', 'cancel-nombre', 'mensajeNombreVacio', true)">
								<span class="glyphicon glyphicon-ok"></span>
							</button>
						</div>

						<div class="alert alert-danger fade in route_alert" id="mensajeNombreVacio" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> El nombre no puede estar vac�o. Se ha dejado el �ltimo nombre v�lido.
						</div>

						
						<div class="route_description" style="margin-top: 1%">
							<form:label class="route_description_label" path="descripcion">Descripci�n</form:label>
							<input type="hidden" id="descripcion" name="descripcion" value="${recorrido.descripcion}"/>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" id="edit-description" onclick="editField('#descripcionEditada', 'ok-descripcion', 'cancel-descripcion', 'mensajeDescripcionVacia', true)">
								<span class="glyphicon glyphicon-pencil"></span>
							</button>
						</div>

						<div>
							<div>
								<p id="descripcionEditada" style="white-space: pre-wrap;" class="atraction-box atraction-description-box" path="descripcion" contenteditable="false" value="${recorrido.descripcion}">${recorrido.descripcion}</p>
								<textarea onkeydown="calculateMaxLength('#descripcionEditadaTextarea', MAX_DESCRIPCION_RECORRIDO)" style="display:none" rows="1" id="descripcionEditadaTextarea" class="route_box" value="${recorrido.descripcion}">${recorrido.descripcion}</textarea>
							</div>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: red;" id="cancel-descripcion" onclick="cancelField('#descripcionEditada', 'ok-descripcion', 'cancel-descripcion')">
								<span class="glyphicon glyphicon-remove"></span>
							</button>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: green;" id="ok-descripcion" onclick="saveField('#descripcionEditada', 'ok-descripcion', 'cancel-descripcion', 'mensajeDescripcionVacia', true)">
								<span class="glyphicon glyphicon-ok"></span>
							</button>
						</div>
	
						<div class="alert alert-danger fade in route_alert" id="mensajeDescripcionVacia" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> La descripci�n no puede estar vac�a. Se ha dejado la �ltima descripci�n v�lida.
						</div>
					</div>
					
					<!-- Audiogu�a -->
					<div style="width: 100%; height: 10%">
						<div style="width: 100%; height: 10%">
							<label class="atraction-label" path="audioES">Audiogu�a</label>
						</div>
						<input type="hidden" id="audioCambiadoRecorrido" name="audioCambiadoRecorrido" value=0>
						<div style="width: 100%; height: 10%; margin-top: 1%;">
							<!-- Reproducir audiogu�a -->
							<div style="float: left; width: 85%; height: 10%">
								<audio id="audioRecorrido" style="width: 100%;" controls>
								    <source type="audio/mpeg">
								</audio> 
							</div>
							
							<!-- Bot�n agregar audiogu�a -->
							<div style="float: right; width: 15%; height: 10%; text-align: right;">
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
					 	<strong>Error!</strong> El archivo seleccionado no es un audio v�lido. Por favor, introduzca otro.
					</div>
					
					<div class="alert alert-danger fade in atraction-alert-incorrect-audio" id="mensajeAudioRecorridoTamano" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo pesa mas de 3MB. Por favor, seleccione uno de menor tama�o.
					</div>
				</div>
				
				<!-- Bloque derecho -->
				<div class="route_right_block" style="float: right">
					<!-- Mapa -->
					<div id="route_map_group">
						<div id="view_or_edit_route_map" class="view_or_edit_route_map"></div>
						
						<div class="alert alert-danger fade in error_msg_new_route_no_atraction" id="mensajeNingunaAtraccionElegida" style="display: none">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado ninguna atracci�n para el recorrido. Debe poseer al menos una.
						</div>
					</div>
				</div>
			</div>
			
			<div class="route_tables" style="width: 100%;">
				<div class="route_left_block" style="clear: both; float: left; width: 48%; margin-top: 2%;">
					<label>Atracciones de la ciudad</label>
					<div style="width: 100%;" class="panel panel-primary route-panel">
						<div class="panel-body route_panel_body">
							<table id="tablaAtracciones" class="display order-column route_board" cellspacing="0">
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
					
					<div>
						<input id="route_add_language_btn" class="btn btn-default btn-success" type="button" value="Agregar idioma"/>
					</div>
				</div>
				
				<div class="route_right_block" style="float: right; width: 48%; margin-top: 2%;">
					<label>Atracciones del recorrido</label>
					<div style="width: 100%;" class="panel panel-primary route-panel">
						<div class="panel-body route_panel_body">
							<table id="tablaAtraccionesRecorrido" class="display order-column route_board" cellspacing="0">
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
		
		<div class="alert alert-danger fade in error_msg_route_already_exists" id="mensajeCantidadAtracciones" style="display: none;">
		 	<a class="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>&iexclError!</strong> El recorrido debe tener por lo menos dos atracciones seleccionadas.
		</div>	
	
		<div class="alert alert-danger fade in error_msg_route_already_exists" id="mensajeNombreRepetido" style="display: none;">
		 	<a class="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>&iexclError!</strong>El recorrido seleccionado ya se encuentra registrado. Seleccione otro nombre.
		</div>
		
		</form:form>
	</div>
	
	<form:form id="formAtras" action="ciudadVer?idCiudad=${recorrido.recorrido.ciudad.id}" method="post"></form:form>
	<div class="btn-final" style="text-align:center;">
		<input id="botonAtras" class="btn btn-default" type="button" value="Atr�s" />
		<input id="botonGuardar" class="btn btn-default btn-primary" type="button" value="Aceptar" />
	</div>



<div id="route_new_language_popup" style="display: none; width: 50%; height: 60%">
	<div style="margin-left: 5%; margin-right: 5%; width: 90%; height: 90%">
		<form:form class="route_new_language" style="width: 100%; height: 100%" id="formRecorridoNuevoLenguaje" name="formRecorridoNuevoLenguaje" action="nuevoLenguajeRecorrido" method="post" commandName="atraccion" enctype="multipart/form-data">
			<h2 style="width: 100%; height: 12%">A�adir lenguaje</h2>
			
			<div style="width: 100%; height: 27%">
				<div style="display: inline-block;">
					<label class="atraction-label" path="descripcion">Descripci�n</label><font color="red"> *</font>
				</div>
				
				<div>
					<textarea onkeydown="calculateMaxLength('#recorridoDescripcionNuevoLenguaje', MAX_DESCRIPCION_RECORRIDO)" id="recorridoDescripcionNuevoLenguaje" path="descripcion" name="recorridoDescripcionNuevoLenguaje" class="atraccion_nuevo_lenguaje_box"  placeholder="Ingrese la descripci�n del recorrido" required="required"/></textarea>
				</div>
			</div>
			<div class="alert alert-danger fade in atraction_new_language_alert" id="mensajeDescripcionVaciaRecorridoNuevoLenguajeError" style="display: none; margin-top: 2%;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> La descripci�n no puede estar vac�a.
			</div>
			
			<div style="width: 100%; height: 30%">
				<div style="width: 100%; height: 40%">
					<label class="atraction-label" path="audio">Audiogu�a</label>
				</div>
				<input type="hidden" id="audioCambiadoRecorridoNuevoLenguaje" name="audioCambiadoRecorridoNuevoLenguaje" value=0>
				<div style="width: 100%; height: 60%">
					<!-- Reproducir audiogu�a -->
					<div style="float: left; width: 85%; height: 50%">
						<audio id="audioRecorridoNuevoLenguaje" style="width: 100%;" controls>
						    <source type="audio/mpeg">
						</audio> 
					</div>
					
					<!-- Bot�n agregar audiogu�a -->
					<div style="float: right; width: 15%; height: 50%; text-align: right;">
						<button type="button" class="btn btn-default btn-sm" id="getAudioRecorridoNuevoLenguaje">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
					
						<button type="button" class="btn btn-default btn-sm" id="borrarAudioRecorridoNuevoLenguaje">
							<span class="glyphicon glyphicon-erase"></span>
						</button>
	
						<input type="file" name="archivoAudioguiaRecorridoNuevoLenguaje" id="archivoAudioguiaRecorridoNuevoLenguaje"/>
					</div>
				</div>
			</div>
			
			<div class="alert alert-danger fade in atraction_new_language_alert" id="mensajeAudioRecorridoNuevoLenguajeIncorrectoError" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El archivo seleccionado no es un audio v�lido. Por favor, introduzca otro.
			</div>
			
			<div class="alert alert-danger fade in atraction_new_language_alert" id="mensajeAudioRecorridoNuevoLenguajeTamano" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El archivo pesa m�s de 3MB. Por favor, seleccione uno de menor tama�o.
			</div>

			<font style="margin-left: 1%;" color="red" size="1">Los campos indicados con * son obligatorios</font>
			
			<div class="alert alert-danger fade in route_alert" id="mensajeAtraccionesQueNoEstanEnAmbosIdiomas" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> Se encuentran atracciones que no cuentan con el idioma requerido.
			</div>
			
			<div class="btn_final_route_new_language_popup" style="width: 100%; text-align:center; clear:both; margin-top: 3%; margin-bottom: 3%;">
				<input id="botonCancelarRecorridoNuevoLenguaje" class="btn btn-default" type="button" value="Cancelar" onclick="closeRouteNewLanguagePopup();"/>
				<input id="botonGuardarRecorridoNuevoLenguaje" class="btn btn-default btn-primary" type="button" value="Guardar" onclick="guardarRecorridoNuevoLenguaje();"/>
			</div>
		</form:form>
	</div>
</div>

<c:set var="idioma">
	${recorrido.idioma}
</c:set>

<c:set var="idRecorrido">
	${recorrido.recorrido.id}
</c:set>

<c:set var="id">
	${recorrido.recorrido.id}
</c:set>

<form:form id="formVer" name="formVer" action="recorridoVer" method="get">
	<input id="idRecorrido" name="idRecorrido" type="hidden" value="${recorrido.recorrido.id}"/>
	<input id="idioma" name="idioma" type="hidden" value="${idioma}"/>
</form:form>

<script src="${pageContext.request.contextPath}/js/ownFunctions.js"></script>

<!-- Definici�n de constantes -->
<script>
const MAX_NOMBRE_RECORRIDO = "50";
const MAX_DESCRIPCION_RECORRIDO = "250";

$("#nombre").attr("maxlength", MAX_NOMBRE_RECORRIDO);
$("#descripcion").attr("maxlength", MAX_DESCRIPCION_RECORRIDO);
</script>

<script>
validateAudio("getAudioRecorridoNuevoLenguaje", "borrarAudioRecorridoNuevoLenguaje", "archivoAudioguiaRecorridoNuevoLenguaje", "audioRecorridoNuevoLenguaje", "audioCambiadoRecorridoNuevoLenguaje", "mensajeAudioRecorridoNuevoLenguajeTamano", "mensajeAudioRecorridoNuevoLenguajeIncorrectoError");
validateAudio("getAudioRecorrido", "borrarAudioRecorrido", "archivoAudioguiaRecorrido", "audioRecorrido", "audioCambiadoRecorrido", "mensajeAudioRecorridoTamano", "mensajeAudioRecorridoIncorrectoError");

var fuera_del_recorrido = new Array();
var dentro_del_recorrido = new Array();

$('#route_add_language_btn').on('click', function(e) {
	e.preventDefault();
	showRouteNewLanguagePopup();
});

$('#botonAtras').on('click', function(e) {
	e.preventDefault();
	document.getElementById("formAtras").submit();
});

function setSpanish() {
	document.formVer.idioma.value = "ES";
	var formData = new FormData();
	formData.append("id","${id}");
	formData.append("language","ES");
	$.ajax({
		url : "checkLenguajeRecorridoExiste",
		type : "POST",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
		success: function (data) {
			if (data == true) {
				document.getElementById("formVer").submit();
			} else {
				bootbox.alert("El recorrido no tiene datos cargados en lenguaje espa�ol.");
			}
		}
	});
}

function setEnglish() {
	document.formVer.idioma.value = "EN";
	var formData = new FormData();
	formData.append("id","${id}");
	formData.append("language","EN");
	$.ajax({
		url : "checkLenguajeRecorridoExiste",
		type : "POST",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
		success: function (data) {
			if (data == true) {
				document.getElementById("formVer").submit();
			} else {
				bootbox.alert("El recorrido no tiene datos cargados en lenguaje ingl�s.");
			}
		}
	});
}

function setLanguage() {
	if ("${idioma}" == "ES") {
		document.getElementById("select_language").innerHTML = "<a class='active dropdown-toggle' data-toggle='dropdown' href='#'>Espa&ntilde;ol<span class='caret'></span></a><ul class='dropdown-menu'><li onclick='setSpanish();'><a href='#'>Espa�ol</a></li><li onclick='setEnglish();'><a href='#'>Ingl�s</a></li></ul></li>";
	} else {
		document.getElementById("select_language").innerHTML = "<a class='active dropdown-toggle' data-toggle='dropdown' href='#'>Ingl&eacute;s<span class='caret'></span></a><ul class='dropdown-menu'><li onclick='setSpanish();'><a href='#'>Espa�ol</a></li><li onclick='setEnglish();'><a href='#'>Ingl�s</a></li></ul></li>";
	}
}

function initializeTables() {
	table_route_atractions.rows().every(function () {
	    var data = this.data();
	    dentro_del_recorrido.push(data["id"]);
	    drawAtractionInMap(data);
	});
	table_all_atractions.rows().every(function () {
	    var data = this.data();
	    if (data["borrado"] ==  0) {
	    	fuera_del_recorrido.push(data["id"]);
	    }
	});
}

$(document).ready(function() {
	$(document).on('click', '#add_atraction', function (e) {
		e.preventDefault();
		var data = table_all_atractions.row(this.closest("tr")).data();
		drawAtractionInMap(data);
		dentro_del_recorrido.push(data["id"]);
		document.getElementById("atraccionesCambiadas").value = 1;
		fuera_del_recorrido.splice(dentro_del_recorrido.indexOf(data["id"]), 1);
		table_route_atractions.row.add({
	        "id":       data.id,
	        "nombre":   data.nombre,
	        "latitud":   data.latitud,
	        "longitud":   data.longitud
	    }).draw();
		table_all_atractions.row(this.closest("tr")).remove().draw();
	});
	
	$(document).on('click', '#remove_atraction', function (e) {
		e.preventDefault();
		var data = table_route_atractions.row(this.closest("tr")).data();
		drawAtractionInMap(data);
		dentro_del_recorrido.splice(dentro_del_recorrido.indexOf(data["id"]), 1);
		fuera_del_recorrido.push(data["id"]);
		document.getElementById("atraccionesCambiadas").value = 1;
		table_all_atractions.row.add({
	        "id":       data.id,
	        "nombre":   data.nombre,
	        "latitud":   data.latitud,
	        "longitud":   data.longitud
	    }).draw();
		table_route_atractions.row(this.closest("tr")).remove().draw();
	});
});

var table_all_atractions = $('#tablaAtracciones').DataTable( {
	dom: 'frtip',
	ajax: "atraccionesFueraRecorridoJson/${idRecorrido}/${idioma}",
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

var table_route_atractions = $('#tablaAtraccionesRecorrido').DataTable( {
	"initComplete": function(settings, json) {
		initializeTables();
	},
	dom: 'frtip',
	ajax: "atraccionesRecorridoJson/${idRecorrido}",
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

$(document).ready(function() {
	checkRecorridoNuevoLenguaje();
	
	<c:if test="${recorrido.audio != null}">
		var audio = document.getElementById('audioRecorrido');
	    audio.src = "${pageContext.request.contextPath}/audioRecorrido?id=" + '${recorrido.id}';
	</c:if>
});

</script>

<c:set var="latitud_ciudad">
	${recorrido.recorrido.ciudad.latitud}
</c:set>

<c:set var="longitud_ciudad">
	${recorrido.recorrido.ciudad.longitud}
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

function hideErrorMessages() {
	document.getElementById("mensajeNombreVacio").style.display = 'none';
	document.getElementById("mensajeDescripcionVacia").style.display = 'none';
	document.getElementById("mensajeAudioRecorridoIncorrectoError").style.display = 'none';
	document.getElementById("mensajeAudioRecorridoTamano").style.display = 'none';
	document.getElementById("mensajeNingunaAtraccionElegida").style.display = 'none';
	document.getElementById("mensajeNombreRepetido").style.display = 'none';
}

function updateForm() {
	document.formModificar.nombre.value = $('#nombreEditado').html();
	document.formModificar.descripcion.value = $('#descripcionEditada').html();
}

$('#botonGuardar').on('click', function(e) {
	e.preventDefault();
	hideErrorMessages();
	updateForm();
	validarRecorridoRepetido();
});

function validarCantidadAtracciones(mensaje, hayError) {
	if ((dentro_del_recorrido.length < 2) && (!hayError)) {
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
	hayError = validarCantidadAtracciones('mensajeCantidadAtracciones', hayError);
	if (hayError == 1) {
		return;
	}
	var ciudad = {
		"id": document.formModificar.idCiudad.value,
	}
	var json = {
		"ciudad": ciudad,
		"id": "${id}",
		"nombre": document.formModificar.nombre.value,
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
				var atracciones_aux = "";
				for (var i = 0; i < dentro_del_recorrido.length; i++) {
					atracciones_aux += dentro_del_recorrido[i] + ",";
				}
				document.formModificar.atracciones.value = atracciones_aux.substring(0, atracciones_aux.length - 1);
			  	document.getElementById("formModificar").submit();
			} else {
				document.getElementById("mensajeNombreRepetido").style.display = 'block';
			}
		}
	});

}
/* ***************************
Agregar Idioma
*****************************/

function checkRecorridoNuevoLenguaje() {
	var formData = new FormData();
	formData.append("id", "${idRecorrido}");
	$.ajax({
		url : "checkAgregarLenguajeRecorrido",
		type : "POST",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
		success: function (data) {
			if (data == true) {
				document.getElementById('route_add_language_btn').style.display = 'none';
			}
		}
	});
}

function guardarRecorridoNuevoLenguaje() {
	hayError = 0;
	hayError = validarElemento('recorridoDescripcionNuevoLenguaje', 'mensajeDescripcionVaciaRecorridoNuevoLenguajeError', hayError);
	if(hayError == 1) {
		return;
	}
	var formData = new FormData();
	formData.append("id","${idRecorrido}");
	formData.append("descripcion",document.getElementById("recorridoDescripcionNuevoLenguaje").value);
	formData.append("audio",document.getElementById("archivoAudioguiaRecorridoNuevoLenguaje").files[0]);
	$.ajax({
		url : "agregarLenguajeRecorrido",
		type : "POST",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
		success: function (data) {
			var atraction_without_the_required_language = false;
			if (data.existe == false) {
				if (data.otroIdioma == true) {
					alert("Ya existe tanto en ingl�s como castellano");
				} else {
					//alert("Se encuentran atracciones que no cuentan con el idioma requerido");
					document.getElementById("mensajeAtraccionesQueNoEstanEnAmbosIdiomas").style.display = "block";
					atraction_without_the_required_language = true;
				}
			}
			if (!atraction_without_the_required_language) {
				closeRouteNewLanguagePopup();
				document.getElementById("route_add_language_btn").style.display = "none";
			}
		}
	});
}

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

function validarElemento(elemento, mensaje, hayError) {
	if ((document.getElementById(elemento).value == '') && (!hayError)) {
		document.getElementById(mensaje).style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById(mensaje).style.display = 'none';
	}
	return hayError;
}
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places&callback=initMap" async defer></script>

</body>
</html>
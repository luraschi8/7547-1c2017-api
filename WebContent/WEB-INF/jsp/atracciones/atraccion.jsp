<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="../template/importacion.jsp"></jsp:include>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trips - ${atraccion.nombre}</title>
</head>

<body>

	<h1 class="page-header atraction-new-page-header">${atraccion.nombre} - ${atraccion.ciudad.nombre}</h1>
	
	<form:form class="form-horizontal maxwid" id ="formModificar" name="formModificar" action="atraccionModificar" method="post" commandName="atraccion" enctype="multipart/form-data">
		<form:input type="hidden" id="id" name="id" path="id" value="${atraccion.id}"/>
		
		<!-- <input type="file" name="archivoImagenPlano" id="archivoImagenPlano"/>
		<input id="planoCambiado" name="planoCambiado" type="hidden" value="0"> -->
		
		<div  class="atraction-new-form"> 
		
			<!-- Información principal y mapa -->
			<div class="atraction-main-information-and-map" style="width: 100%; overflow: hidden;">	
				<!-- Información principal -->
				<div class="atraction-main-information" style="float:left">
					<input type="hidden" id="idCiudad" name="idCiudad" value="${atraccion.ciudad.id}"/>
					<input type="hidden" id="latitudCiudad" name="latitudCiudad" value="${atraccion.ciudad.latitud}"/>
					<input type="hidden" id="latitudCiudad" name="latitudCiudad" value="${atraccion.ciudad.longitud}"/>
	
					<form:input type="hidden" id="latitud" name="latitud" path="latitud"/>
					<form:input type="hidden" id="longitud" name="longitud" path="longitud"/>
					<!--<form:input type="hidden" id="id" name="id" path="id" value="${atraccion.id}"/>--->
					
					<div>
						<form:label class="atraction-label atraction-main-information-label" path="nombre">Nombre</form:label>
						<input type="hidden" id="nombre" name="nombre" value="${atraccion.nombre}"/>
						<input type="button" id="edit-name" class="btn-edit-main-information" onclick="editField('#nombreEditado', 'ok-nombre', 'cancel-nombre', 'mensajeNombreVacio', true)" value="Editar">
					</div>
					<div>
						<p id="nombreEditado" class="atraction-box atraction-name-box" path="nombre" contenteditable="false" value="${atraccion.nombre}">${atraccion.nombre}</p>
						<input type="button" style="display:none;" id="ok-nombre" class="btn-edit-main-information"  onclick="saveField('#nombreEditado', 'ok-nombre', 'cancel-nombre', 'mensajeNombreVacio', true)" value="Aceptar">
						<input type="button" style="display:none;" id="cancel-nombre" class="btn-edit-main-information" onclick="cancelField('#nombreEditado', 'ok-nombre', 'cancel-nombre')" value="Cancelar">
					</div>
					
					<div class="alert alert-warning fade in atraction-alert" id="mensajeNombreVacio" style="display: none;">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> El nombre no puede estar vacío. Se ha dejado el último nombre válido.
					</div>
					
					<div>
						<form:label class="atraction-label atraction-description-label" path="descripcion">Descripción</form:label>
						<input type="hidden" id="descripcion" name="descripcion" value="${atraccion.descripcion}"/>
						<input type="button" id="edit-description" class="btn-edit-main-information" onclick="editField('#descripcionEditada', 'ok-descripcion', 'cancel-descripcion', 'mensajeDescripcionVacia', true)" value="Editar">
					</div>
					<div>
					    <p id="descripcionEditada" class="atraction-box atraction-name-box" path="descripcion" contenteditable="false" value="${atraccion.descripcion}">${atraccion.descripcion}</p>
						<input type="button" style="display:none;" id="ok-descripcion" class="btn-edit-main-information"  onclick="saveField('#descripcionEditada', 'ok-descripcion', 'cancel-descripcion', 'mensajeDescripcionVacia', true)" value="Aceptar">
						<input type="button" style="display:none;" id="cancel-descripcion" class="btn-edit-main-information" onclick="cancelField('#descripcionEditada', 'ok-descripcion', 'cancel-descripcion')" value="Cancelar">
					</div>
					
					<div class="alert alert-warning fade in atraction-alert" id="mensajeDescripcionVacia" style="display: none;">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> La descripción no puede estar vacía. Se ha dejado la última descripción válida.
					</div>
					
					<div>
						<form:label class="atraction-label atraction-schedule-label" path="horario">Horario</form:label>
						<input type="hidden" id="horario" name="horario" value="${atraccion.horario}"/>
						<input type="button" id="edit-horario" class="btn-edit-main-information" onclick="editField('#horarioEditado', 'ok-horario', 'cancel-horario', null, false)" value="Editar">
					</div>
					<div>
						<p id="horarioEditado" class="atraction-box atraction-name-box" path="horario" contenteditable="false" value="${atraccion.horario}">${atraccion.horario}</p>
						<input type="button" style="display:none;" id="ok-horario" class="btn-edit-main-information"  onclick="saveField('#horarioEditado', 'ok-horario', 'cancel-horario', null, false)" value="Aceptar">
						<input type="button" style="display:none;" id="cancel-horario" class="btn-edit-main-information" onclick="cancelField('#horarioEditado', 'ok-horario', 'cancel-horario')" value="Cancelar">
					</div>
					
					<div>
						<form:label class="atraction-label atraction-cost-label" path="precio">Precio</form:label>
						<input type="hidden" id="precio" name="precio" value="${atraccion.precio}"/>
						<input type="button" id="edit-precio" class="btn-edit-main-information" onclick="editField('#precioEditado', 'ok-precio', 'cancel-precio', null, false)" value="Editar">
					</div>
					<div>
						<p id="precioEditado" class="atraction-box atraction-name-box" path="precio" contenteditable="false" value="${atraccion.precio}">${atraccion.precio}</p>
						<input type="button" style="display:none;" id="ok-precio" class="btn-edit-main-information"  onclick="saveField('#precioEditado', 'ok-precio', 'cancel-precio', null, false)" value="Aceptar">
						<input type="button" style="display:none;" id="cancel-precio" class="btn-edit-main-information" onclick="cancelField('#precioEditado', 'ok-precio', 'cancel-precio')" value="Cancelar">
					</div>
					
					<div>
						<form:label id="recorrible" name="recorrible" class="atraction-label atraction-recorrible-label" path="recorrible">&iquestEs recorrible?</form:label>
						  	<div>
							  	<input type="radio" id="es-recorrible" name="recorrible" path="recorrible" value="1" style="margin: 4px">Sí
							  	<input type="radio" id="no-es-recorrible" name="recorrible" path="recorrible" value="0" style="margin: 4px; margin-left: 15px;">No
							</div>
						</form>
					</div>
				</div>
		
				<!-- Mapa -->
				<div style="float:right">
					<input id="atraction-map-input" class="atraction-map-controls" type="text" placeholder="Ingresar ubicación">
					<div id="atraction-map"></div> 
					
					<input type="button" id="edit-coordinates" class="btn-edit-main-information" onclick="editCoordinates()" value="Editar ubicación">
					<input type="button" style="display:none;" id="ok-coordinates" class="btn-edit-main-information"  onclick="saveCoordinates()" value="Aceptar">
					<input type="button" style="display:none;" id="cancel-coordinates" class="btn-edit-main-information" onclick="cancelEditingCoordinates()" value="Cancelar">
					
					<div class="alert alert-warning fade in atraction-alert-no-location" id="mensajeUbicacionVacia" style="display: none">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> No se ha seleccionado una ubicación para la atracción.
					</div>
					
					<div class="alert alert-warning fade in atraction-alert-no-location" id="mensajeUbicacionLejana" style="display: none">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclAdvertencia!</strong> La atracción seleccionada está a más de 15km de la ciudad actual.
					</div>
					
				</div>
			</div>
	
			<!-- Plano y tabla -->
			<div class="atraction-bluprints-and-chart" style="width: 100%; overflow: hidden;">
			
				<!-- Plano -->
				<div class="atraction-blueprints-group" style="float:left">
					<div>
						<form:label class="atraction-label atraction-blueprints-label" path="plano">Plano</form:label>
					</div>
					<div class="atraction-blueprints-box" style="float:left">
						<img id="plano" src="/Trips/planoAtraccion?id=${atraccion.id}" style="width:100%; height:100%">
						<input type="button" id="atraction-get-blueprints" class="btn btn-default atraction-get-blueprints" value="Editar">
						<input type="file" name="archivoPlano" id="archivoPlano"/>
					</div>
	
					<div class="alert-message">
						<div class="alert alert-warning fade in" id="mensajePlanoNecesario" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> La atracción es recorrible. Debe proporcionarse un plano.
						</div>
						<div class="alert alert-warning fade in" id="mensajeImagenIncorrectaError" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otra.
						</div>
					</div>
					
					
					
					
					
					<!-- Galería -->
					<div>
					
						<div>
							<form:label class="atraction-label atraction-gallery-label" path="listaImagenes">Galería</form:label>
						</div>
						<div class="atraction-gallery-box" style="float:left">
							<img class="atraction-gallery" id="atraction-gallery" style="width:100%; height:100%">
							<button class="w3-button w3-display-left atraction-gallery-slide-left" onclick="nextGalleryItem(-1)">&#10094;</button>
							<button class="w3-button w3-display-right atraction-gallery-slide-right" onclick="nextGalleryItem(+1)">&#10095;</button>
						
							<input type="button" id="atraction-get-gallery-file" class="btn btn-default btn-atraction-get-gallery-file" value="+">
						        
						    <input type="file" multiple name="archivoGaleria" id="archivoGaleria"/>
						</div>
						
					
						
					</div>
					
					
					
					
					<!-- Audioguía -->
					<form:label class="atraction-label atraction-audio-label" path="audioES">Audioguía</form:label>
					<div>
						<!-- Reproducir audioguía -->
						<div style="float:left">
							<audio id="audio" controls>
							    <source type="audio/mpeg">
							</audio> 
						</div>
						
						<!-- Botón agregar audioguía -->
						<div style="text-align:center; float:right;">
							<input type="button" id="atraction-get-audio-file" class="btn btn-default btn-atraction-get-audio-file" value="Editar audioguía">
							<input type="file" name="archivoAudioguia" id="archivoAudioguia"/>
						</div>
					</div>
					
					<div class="alert alert-warning fade in atraction-alert-incorrect-audio" id="mensajeAudioIncorrectoError" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>Error!</strong> El archivo seleccionado no es un audio válido. Por favor, introduzca otro.
						</div>
						
				</div>
				
				
	
						
				<!-- Tabla puntos de interés y obras -->
				<div class="panel panel-primary view-atraction-panel" style="float:right">
					<div style="text-align:center">
						<input id="botonPuntosDeInteres" class="btn btn-ver-puntos-y-obras btn-puntos-de-interes" type="button" value="Puntos de interés" />
						
						<form class="form-horizontal maxwid" id="formAgregarPuntoDeInteres" name="formAgregarPuntoDeInteres" action="puntoDeInteresNuevo" method="post">
							<input id="botonAgregarPuntoDeInteres" class="btn btn-agregar-puntos-y-obras btn-nuevo-punto-de-interes" type="button" value="+" />
						</form>
						
						<input id="botonObras" class="btn btn-ver-puntos-y-obras btn-obras" type="button" value="Obras" />
						
						<form class="form-horizontal maxwid" id ="formAgregarObra" name="formAgregarObra" action="obraNuevo" method="post">
							<input id="botonAgregarObra" class="btn btn-agregar-puntos-y-obras btn-nueva-obra" type="button" value="+" />
						</form>
					</div>
					
					<div class="panel-body atraction-points-of-interest">
						<table id="tablita" class="display order-column view-atraction-board" cellspacing="0" width="100%">
							<thead>
								<tr>
									<th></th> <!-- Imagen -->
									<th></th> <!-- Nombre -->
									<th></th> <!-- Borrar -->
									<th></th> <!-- Ver -->
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
				</div>
				
				<!-- Tabla reseñas (comentarios) -->
				<div class="panel panel-primary view-atraction-panel" style="float:right">
					<div style="text-align:center; font-size:110%">
						<p>Reseñas</p>
					</div>
					
					<div class="panel-body atraction-comments">
						<table id="tablita" class="display order-column view-atraction-board" cellspacing="0" width="100%">
							<thead>
								<tr>
									<th></th> <!-- Usuario -->
									<th></th> <!-- Comentario -->
									<th></th> <!-- Borrar -->
									<th></th> <!-- Editar -->
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
				</div>				
			</div>
			
			<div class="alert alert-warning fade in atraction-alert-already-exists" id="mensajeNombreRepetido" style="display: none;">
			 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> La atracción seleccionada ya se encuentra registrada. Seleccione otra.
			</div>
			
		</div>
	</form:form>

<form:form id="formAtras" action="ciudadVer?idCiudad=${atraccion.ciudad.id}" method="post"></form:form>
<div class="btn-final" style="text-align:center;">
	<input id="botonAtras" class="btn btn-default" type="button" value="Cancelar" />
	<input id="botonNuevo" class="btn btn-default" type="button" value="Guardar" />
</div>


<!-- Definición de constantes -->
<script>
	const MAX_NOMBRE = "50";
	const MAX_DESCRIPCION = "250";
	const MAX_HORARIO = "50";
	const MAX_PRECIO = "50";
	$("#nombreEditado").attr("maxlength", MAX_NOMBRE);
	$("#descripcionEditada").attr("maxlength", MAX_DESCRIPCION);
	$("#horarioEditado").attr("maxlength", MAX_HORARIO);
	$("#precioEditado").attr("maxlength", MAX_PRECIO);
	//document.formModificar.plano.value = ${atraccion.plano};
	alert("Hola");
	alert($("#archivoPlano").val());
	alert(${atraccion.id});
	//alert(${atraccion.plano});
	//$("#archivoPlano").val(${atraccion.plano});
	//alert($("#archivoPlano").val());*/

	if (${atraccion.recorrible}) {
		$("#es-recorrible").attr("checked", "checked");
	} else {
		$("#no-es-recorrible").attr("checked", "checked");
	}
</script>

<script>
function editField(field, ok, cancel, vacio, obligatorio) {
	if (obligatorio) {
		document.getElementById(vacio).style.display = "none";
	}
	if (!$(field).val()) {
		$(field).val($(field).html());
	}
    $(field).attr("contenteditable", "true").focus();
    displayOkAndCancelButtons(ok, cancel);
}

function displayOkAndCancelButtons(ok, cancel) {
	document.getElementById(ok).style.display = "inline-block";
    document.getElementById(cancel).style.display = "inline-block";
}

function hideOkAndCancelButtons(ok, cancel) {
	document.getElementById(ok).style.display = "none";
    document.getElementById(cancel).style.display = "none";
}

function saveField(field, ok, cancel, vacio, obligatorio) {
	hideOkAndCancelButtons(ok, cancel);
	if (($(field).html()) || (!obligatorio)) {
		$(field).val($(field).html());
	} else {
		if (obligatorio) {
			document.getElementById(vacio).style.display = "block";
			$(field).html($(field).val());
		}
	}
	var max = $(field).attr("maxlength");
	$(field).text(function(index, currentText) {
	    return currentText.substr(0, max);
	});
	$(field).attr("contenteditable", "false");
}

function cancelField(field, ok, cancel) {
	hideOkAndCancelButtons(ok, cancel);
    $(field).html($(field).val());
	$(field).attr("contenteditable", "false");
}

function updateForm() {
	document.formModificar.nombre.value = $('#nombreEditado').html();
	document.formModificar.descripcion.value = $('#descripcionEditada').html();
	document.formModificar.horario.value = $('#horarioEditado').html();
	document.formModificar.precio.value = $('#precioEditado').html();
	document.formModificar.recorrible.value = $("input[name='recorrible']:checked").val();
}

$('#botonAtras').on('click', function(e) {
	e.preventDefault();
	document.getElementById("formAtras").submit();
});

$('#botonNuevo').on('click', function(e) {
	e.preventDefault();
	document.getElementById("mensajeNombreRepetido").style.display = 'none';
	document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	document.getElementById("mensajeAudioIncorrectoError").style.display = 'none';
	updateForm();
	updateCoordinatesForm();
	validarAtraccionRepetida();
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

function validarAtraccionRepetida() {
	hayError = 0;
	hayError = validarElemento('nombre', 'mensajeNombreVacio', hayError);
	hayError = validarElemento('descripcion', 'mensajeDescripcionVacia', hayError);
	
	if (document.getElementById('es-recorrible').checked) {
		hayError = validarElemento('archivoPlano', 'mensajePlanoNecesario', hayError);
	} else {
		document.getElementById("mensajePlanoNecesario").style.display = 'none';
	}

	if (hayError == 1) {
		return;
	} 

	var ciudad = {
		"id": document.formModificar.idCiudad.value,
	}
	var json = {
		"ciudad": ciudad,
		"id": document.formModificar.id.value,
		"nombre": document.formModificar.nombre.value
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
				document.formModificar.recorrible.value = $("input[name='recorrible']:checked").val();
				document.getElementById("formModificar").submit();
			} else {
				document.getElementById("mensajeNombreRepetido").style.display = 'block';
			}
		}
	});
}
</script>




<!-- Plano -->
<script>
$(document).ready(function() {
	validateImage("atraction-get-blueprints", "archivoPlano", "plano", "mensajeImagenIncorrectaError");
});
</script>






<!-- Para el slide de Galería podría ser útil -->
<script>
var slideIndex = 1;
showDivs(slideIndex);

function nextGalleryItem(n) {
    showDivs(slideIndex += n);
}

function showDivs(n) {
    var i;
    var x = document.getElementsByClassName("atraction-gallery");
    if (n > x.length) {slideIndex = 1}
    if (n < 1) {slideIndex = x.length} ;
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    x[slideIndex-1].style.display = "block";
}
</script>

<!-- Galería -->
<script>
var number_of_images = 0;
var number_of_videos = 0;

var number_of_files = number_of_images + number_of_videos;

$(document).ready(function() {
	document.getElementById('atraction-get-gallery-file').onclick = function() {
		document.getElementById('archivoGaleria').addEventListener('change', readURL, true);
		var fileButton = document.getElementById('archivoGaleria');
		fileButton.click();
	};
	
	$("#archivoGaleria").change(function() {
	    var val = $(this).val();
	    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
	    	case 'gif': case 'jpg': case 'png': case 'jpeg': case 'bmp': 
	        	document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	        	break;
	        default:
	            $(this).val('');
				document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
				document.getElementById('archivoGaleria').value = "" ;
				document.getElementById('galeria').src = "" ;
				break;
	    }
	});
	
	function readURL(){
		var file = document.getElementById("archivoGaleria").files[0];
		var reader = new FileReader();
	    reader.onloadend = function(){
			document.getElementById('galeria').src = reader.result;
		}
		if(file) {
			reader.readAsDataURL(file);
		} 
	}
});
</script>




<!-- Audioguía -->
<script>
$(document).ready(function() {
	document.getElementById('atraction-get-audio-file').onclick = function() {
		document.getElementById('archivoAudioguia').addEventListener('change', readURL, true);
		var fileButton = document.getElementById('archivoAudioguia');
		fileButton.click();
	};
	
	$("#archivoAudioguia").change(function() {
	    var val = $(this).val();
	    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
	        case 'mp3':
	        	document.getElementById("mensajeAudioIncorrectoError").style.display = 'none';
	        	break;
	        default:
	            $(this).val('');
				document.getElementById("mensajeAudioIncorrectoError").style.display = 'block';
				document.getElementById('archivoAudioguia').value = "" ;
				document.getElementById('audio').src = "" ;
				break;
	    }
	});
	
	function readURL(){
		var file = document.getElementById("archivoAudioguia").files[0];
		var reader = new FileReader();
	    reader.onloadend = function(){
			document.getElementById('audio').src = reader.result;
		}
		if(file) {
			reader.readAsDataURL(file);
		} 
	}
});
</script>





<c:set var="latitud_atraccion">
	${atraccion.latitud}
</c:set>

<c:set var="longitud_atraccion">
	${atraccion.longitud}
</c:set>

<c:set var="latitud_ciudad">
	${atraccion.ciudad.latitud}
</c:set>

<c:set var="longitud_ciudad">
	${atraccion.ciudad.longitud}
</c:set>

<!-- Mapa -->
<script>
var map, marker, autocomplete, infowindow, input, aux_lat, aux_lng,
	map_lat = document.formModificar.latitud.value,
	map_lng = document.formModificar.longitud.value;

function updateCoordinatesForm() {
	document.formModificar.latitud.value = map_lat;
	document.formModificar.longitud.value = map_lng;
}

function hideOkAndCancelButtonsForCoordinates() {
	document.getElementById('ok-coordinates').style.display = "none";
    document.getElementById('cancel-coordinates').style.display = "none";
}

function setPosition(lat, lng) {
	var position = new google.maps.LatLng(lat, lng);
	marker.setPosition(position);
	hideOkAndCancelButtonsForCoordinates();
}

function saveCoordinates() {
	google.maps.event.clearInstanceListeners(map);
	map_lat = aux_lat;
	map_lng = aux_lng;
	setPosition(map_lat, map_lng);
	hideOkAndCancelButtonsForCoordinates();
}

function cancelEditingCoordinates() {
	google.maps.event.clearInstanceListeners(map);
	setPosition(map_lat, map_lng);
}

function editCoordinates() {
	document.getElementById('ok-coordinates').style.display = "inline-block";
    document.getElementById('cancel-coordinates').style.display = "inline-block";
	autocomplete.addListener('place_changed', function() {
	    infowindow.close();
	    marker.setVisible(false);
	    var place = autocomplete.getPlace();
	    if (!place.geometry) {
	        window.alert("Autocomplete's returned place contains no geometry");
	        return;
	    }
	
	    // If the place has a geometry, then present it on a map.
	    if (place.geometry.viewport) {
	        map.fitBounds(place.geometry.viewport);
	    } else {
	        map.setCenter(place.geometry.location);
	        map.setZoom(17);  // Why 17? Because it looks good.
	    }
	    marker.setIcon(/** @type {google.maps.Icon} */({
	        url: place.icon,
	        size: new google.maps.Size(71, 71),
	        origin: new google.maps.Point(0, 0),
	        anchor: new google.maps.Point(17, 34),
	        scaledSize: new google.maps.Size(35, 35)
	    }));
	    marker.setPosition(place.geometry.location);
	    marker.setVisible(true);
	
	    // Se guardan las coordenadas
	    aux_lat = place.geometry.location.lat();
	    aux_lng = place.geometry.location.lng();
	
	    var address = '';
	    if (place.address_components) {
	        address = [
	            (place.address_components[0] && place.address_components[0].short_name || ''),
	            (place.address_components[1] && place.address_components[1].short_name || ''),
	            (place.address_components[2] && place.address_components[2].short_name || '')
	        ].join(' ');
	    }
	
	    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
	    infowindow.open(map, marker);
	});
	
	// Al clickear en el mapa, se guardan las coordenadas y se dibuja la ubicación
	google.maps.event.addListener(map, 'click', function(event) {
		marker.setVisible(false);
		marker.setPosition(event.latLng);
	    marker.setVisible(true);
	
		// Se guardan las coordenadas
		aux_lat = event.latLng.lat();
		aux_lng = event.latLng.lng();
	   	
	   	// Se verifica si la ubicación seleccionada se encuentra a más de 15km.
	   	var city_coordinates = new google.maps.LatLng(${latitud_ciudad}, ${longitud_ciudad});
		if (google.maps.geometry.spherical.computeDistanceBetween(event.latLng, city_coordinates) < 15000) {
			document.getElementById("mensajeUbicacionLejana").style.display = 'none';
	    } else {
	    	document.getElementById("mensajeUbicacionLejana").style.display = 'block';
	    }
	});


}


    function initMap() {
    	map = new google.maps.Map(document.getElementById('atraction-map'), {
    	    center: {lat: ${latitud_atraccion}, lng: ${longitud_atraccion}},
    	    zoom: 13
    	});
    	
        input = (document.getElementById('atraction-map-input'));
    	map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    	autocomplete = new google.maps.places.Autocomplete(input, {types: []});
    	autocomplete.bindTo('bounds', map);
    	
    	infowindow = new google.maps.InfoWindow();
    	marker = new google.maps.Marker({
    	    map: map,
    	    anchorPoint: new google.maps.Point(0, -29)
    	});

    	marker.setIcon(({
	        size: new google.maps.Size(71, 71),
	        origin: new google.maps.Point(0, 0),
	        anchor: new google.maps.Point(17, 34),
	        scaledSize: new google.maps.Size(35, 35)
	    }));
	    marker.setPosition(map.center);
    	marker.setVisible(true);
    }
</script>
		
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places,geometry&callback=initMap&language=es" async defer></script>

</body>
</html>
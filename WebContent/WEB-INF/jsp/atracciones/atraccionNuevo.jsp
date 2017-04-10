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
	<h1 class="page-header atraction-new-page-header">Nueva atracción</h1>
	
	<form:form class="form-horizontal maxwid" id ="formNuevo" name="formNuevo" action="atraccionNuevoValidar" method="post" commandName="atraccion" enctype="multipart/form-data">
	<div  class="atraction-new-form"> 
	
		<!-- Información principal y mapa -->
		<div class="atraction-main-information-and-map" style="width: 100%; overflow: hidden;">	
			<!-- Información principal -->
			<div class="atraction-main-information" style="float:left">
				<input type="hidden" id="idCiudad" name="idCiudad" value="${atraccion.ciudad.id}"/>
				<input type="hidden" id="latitudCiudad" name="latitudCiudad" value="${atraccion.ciudad.latitud}"/>

				<form:input type="hidden" id="latitud" name="latitud" path="latitud"/>
				<form:input type="hidden" id="longitud" name="longitud" path="longitud"/>
				<input type="hidden" id="id" name="id" value="${atraccion.id}"/>
				
				<div>
					<form:label class="atraction-label atraction-name-label" path="nombre">Nombre</form:label>
				</div>
				<div>
				    <form:input id="nombre" class="atraction-box atraction-name-box" type="text" path="nombre" required="required" placeholder="Ingrese el nombre de la atracción"/>
				</div>
				
				<div class="alert alert-warning fade in atraction-alert" id="mensajeNombreVacio" style="display: none;">
				 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>&iexclError!</strong> No se ha seleccionado un nombre para la atracción.
				</div>
				
				<div>
					<form:label class="atraction-label atraction-description-label" path="descripcion">Descripción</form:label>
				</div>
				<div>
				    <form:input id="descripcion" class="atraction-box atraction-description-box" type="text" path="descripcion" required="required" placeholder="Ingrese la descripción de la atracción"/>
				</div>
				
				<div class="alert alert-warning fade in atraction-alert" id="mensajeDescripcionVacia" style="display: none;">
				 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>&iexclError!</strong> No se ha seleccionado una descripción para la atracción.
				</div>
				
				<div>
					<form:label class="atraction-label atraction-schedule-label" path="horario">Horario</form:label>
				</div>
				<div>
					<form:input id="horario" class="atraction-box atraction-schedule-box" type="text" path="horario" placeholder="Ingrese el horario de visita de la atracción"/>
				</div>
				
				<div>
					<form:label class="atraction-label atraction-cost-label" path="precio">Precio</form:label>
				</div>
				<div>
					<form:input id="precio" class="atraction-box atraction-cost-box" type="text" path="precio" placeholder="Ingrese el costo de la atracción"/>
				</div>
				
				<div>
					<form:label class="atraction-label atraction-recorrible-label" path="recorrible">&iquestEs recorrible?</form:label>
					  	<div>
						  	<input type="radio" id="es-recorrible" name="recorrible" path="recorrible" value="1" style="margin: 4px">Sí
						  	<input type="radio" id="no-es-recorrible" name="recorrible" path="recorrible" value="0" checked="checked" style="margin: 4px; margin-left: 15px;">No
						</div>
					</form>
				</div>
			</div>
	
			<!-- Mapa -->
			<div style="float:right">
				<input id="atraction-map-input" class="atraction-map-controls" type="text" placeholder="Ingresar ubicación">
				<div id="atraction-map"></div> 
				
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
					<img id="plano" style="width:100%; height:100%">
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
					<div id ="container" class="atraction-gallery-box" style="float:left">
						<img class="atraction-gallery" id="imagenGaleria" style="width:100%; height:100%;">
						<video id="videoGaleria" style="width:100%; height:100%;display:none" controls >
						</video>
						<button type="button" class="w3-button w3-display-left atraction-gallery-slide-left" onclick="nextGalleryItem(-1)">&lt;</button>
						<button type="button" class="w3-button w3-display-right atraction-gallery-slide-right" onclick="nextGalleryItem(+1)">&#10095;</button>
						<input type="button" id="atraction-get-gallery-file" class="btn btn-default btn-atraction-get-gallery-file" value="+">
					    
					    <!-- <input type="file" multiple name="archivoGaleria" id="archivoGaleria"/> -->
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
						<input type="button" id="atraction-get-audio-file" class="btn btn-default btn-atraction-get-audio-file" value="Agregar audioguía">
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
	$("#nombre").attr("maxlength", MAX_NOMBRE);
	$("#descripcion").attr("maxlength", MAX_DESCRIPCION);
	$("#horario").attr("maxlength", MAX_HORARIO);
	$("#precio").attr("maxlength", MAX_PRECIO);
</script>


<script>
$('#botonAtras').on('click', function(e) {
	e.preventDefault();
	document.getElementById("formAtras").submit();
});

$('#botonNuevo').on('click', function(e) {
		e.preventDefault();
		document.getElementById("mensajeNombreRepetido").style.display = 'none';
		document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
		document.getElementById("mensajeAudioIncorrectoError").style.display = 'none';
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

function validarAtraccionRepetida() {
	hayError = 0;
	hayError = validarElemento('nombre', 'mensajeNombreVacio', hayError);
	hayError = validarElemento('descripcion', 'mensajeDescripcionVacia', hayError);
	hayError = validarUbicacion(location_selected, "mensajeUbicacionVacia", hayError);
	
	if (document.getElementById('es-recorrible').checked) {
		hayError = validarElemento('archivoPlano', 'mensajePlanoNecesario', hayError);
	} else {
		document.getElementById("mensajePlanoNecesario").style.display = 'none';
	}
	
	if (hayError == 1) {
		return;
	} 
	var ciudad = {
		"id": document.formNuevo.idCiudad.value,
	}
	var json = {
		"ciudad": ciudad,
		"nombre": document.formNuevo.nombre.value,
		"latitud": document.formNuevo.latitud.value,
		"longitud": document.formNuevo.longitud.value
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
				document.formNuevo.recorrible.value = $("input[name='recorrible']:checked").val();
				document.getElementById("formNuevo").submit();
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

var imageNumber = 0;
var videoNumber = 0;

var filesNumber = imageNumber + videoNumber;

var multimedia = [];

var slideIndex = 1;

function nextGalleryItem(n) {
    showDivs(slideIndex += n);
}

function showDivs(n) {
    var i;
    if (n > filesNumber) {slideIndex = 1}
    if (n < 1) {slideIndex = filesNumber};
    multi = multimedia[slideIndex - 1];
    console.log(multi);
    if (multi.imagen == 1) {
		hideGalleryVideo();
		document.getElementById('imagenGaleria').src = multimedia[slideIndex - 1].src;
		console.log("IMAGEN");
	} else {
		hideGalleryImage();
		console.log("VIDEO");
	}
}

function hideGalleryImage() {
	document.getElementById('imagenGaleria').style.display = 'none';
	document.getElementById('videoGaleria').style.display = 'block';
}

function hideGalleryVideo() {
	document.getElementById('imagenGaleria').style.display = 'block';
	document.getElementById('videoGaleria').style.display = 'none';
}



/*--------Galería-----------*/

$(document).ready(function() {
	document.getElementById('atraction-get-gallery-file').onclick = function() {
		input = document.createElement('input');
		input.type='file';
		input.id = 'archivoGaleria';
		container = document.getElementById("container");
		container.appendChild(input);
		document.getElementById('archivoGaleria').addEventListener('change', readURL, true);
		console.log("input");
		console.log(input);
		input.click();
	};
	
	function readURL(){
		document.getElementById('archivoGaleria').style.display = 'none';
		var file = document.getElementById("archivoGaleria").files[0];
		val = file.name;
		container = document.getElementById("container");
		var imageVideo = [];
		isVideo = false;
		videoType = '';
		ext = val.substring(val.lastIndexOf('.') + 1).toLowerCase()
		switch(ext){
	    	case 'gif': case 'jpg': case 'png': case 'jpeg': case 'bmp': 
	        	document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	        	tagImagen = document.createElement('img');
	        	imageVideo.file = tagImagen;
	        	document.getElementById('archivoGaleria').style.display = 'none';
	        	document.getElementById('archivoGaleria').name = 'archivoGaleria' + imageNumber;
				document.getElementById('archivoGaleria').id = 'archivoGaleria' + imageNumber;
				imageNumber = imageNumber + 1;
	        	break;
	        case 'mp4': case 'avi': 
	        	isVideo = true;
	        	if (ext == 'mp4') {
	        		videoType='video/mp4';
	        	} else {
	        		videoType='video/avi';
	        	}
	        	document.getElementById('archivoGaleria').name = 'unVideo';
	        	document.getElementById('archivoGaleria').id = 'archivoGaleria' + filesNumber;	        
	        	break;
	        default:
	            $(this).val('');
				document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
				document.getElementById('archivoGaleria').value = "" ;
				document.getElementById('galeria').src = "" ;
				break;
	    }
		var reader = new FileReader();
	    reader.onloadend = function(){
	    	imageVideo.src = reader.result;
	    	if (!isVideo) {
	    		imageVideo.imagen = 1;
				document.getElementById('imagenGaleria').src = reader.result;
				document.getElementById('imagenGaleria').style.display = 'block';
				document.getElementById('videoGaleria').style.display = 'none';
			} else {
				imageVideo.imagen = 0;
				videoNumber = 1;
				document.getElementById('imagenGaleria').style.display = 'none';
				video = document.getElementById('videoGaleria');
				video.style.display = 'block';
				var source = document.createElement('source');
			    source.src = reader.result;
			    source.type = videoType;
				video.appendChild(source);
			}
			multimedia.push(imageVideo);
		}
		if(file) {
			reader.readAsDataURL(file);
		}
		filesNumber = imageNumber + videoNumber;
		slideIndex = filesNumber - 1;
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

<c:set var="latitud_ciudad">
	${atraccion.ciudad.latitud}
</c:set>

<c:set var="longitud_ciudad">
	${atraccion.ciudad.longitud}
</c:set>

<!-- Mapa -->
<script>
    function initMap() {
        var map = new google.maps.Map(document.getElementById('atraction-map'), {
            center: {lat: ${latitud_ciudad}, lng: ${longitud_ciudad}},
            zoom: 13
        });
        var input = (document.getElementById('atraction-map-input'));

        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

        var autocomplete = new google.maps.places.Autocomplete(input, {types: []});
        autocomplete.bindTo('bounds', map);

        var infowindow = new google.maps.InfoWindow();
        var marker = new google.maps.Marker({
            map: map,
            anchorPoint: new google.maps.Point(0, -29)
        });

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
            document.formNuevo.latitud.value = place.geometry.location.lat();
            document.formNuevo.longitud.value = place.geometry.location.lng();
            location_selected = true;

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
        google.maps.event.addListener(map, 'click', function( event ){
       		marker.setVisible(false);
       		marker.setPosition(event.latLng);
            marker.setVisible(true);

			// Se guardan las coordenadas
       	  	document.formNuevo.latitud.value = event.latLng.lat();
           	document.formNuevo.longitud.value = event.latLng.lng();
           	location_selected = true;

           	// Se verifica si la ubicación seleccionada se encuentra a más de 15km.
           	var city_coordinates = new google.maps.LatLng(${latitud_ciudad}, ${longitud_ciudad});
        	if (google.maps.geometry.spherical.computeDistanceBetween(event.latLng, city_coordinates) < 15000) {
        		document.getElementById("mensajeUbicacionLejana").style.display = 'none';
            } else {
            	document.getElementById("mensajeUbicacionLejana").style.display = 'block';
            }
        });
    }
</script>
		
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places,geometry&callback=initMap&language=es" async defer></script>

</body>
</html>
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

	<h1 class="page-header atraction-new-page-header" style="margin-left: 5rem">Nueva atracci�n</h1>
	
	<form:form id ="formNuevo" name="formNuevo" action="atraccionNuevoValidar" method="post" commandName="atraccion" enctype="multipart/form-data">
	
		<div class="atraction-new-form" style="width: 100%; overflow: hidden;"> 
		
			<!-- Bloque izquierdo -->
			<div class="atraction-main-information-and-map" style="float:left; margin-top:-1.5rem">
	
				<!-- Informaci�n principal -->
				<div class="atraction-main-information">
					<input type="hidden" id="idCiudad" name="idCiudad" value="${atraccion.ciudad.id}"/>
					<input type="hidden" id="latitudCiudad" name="latitudCiudad" value="${atraccion.ciudad.latitud}"/>
	
					<form:input type="hidden" id="latitud" name="latitud" path="latitud"/>
					<form:input type="hidden" id="longitud" name="longitud" path="longitud"/>
					<input type="hidden" id="id" name="id" value="${atraccion.id}"/>
					
					<div>
						<form:label class="atraction-label atraction-name-label" path="nombre">Nombre</form:label>
					</div>
					<div>
						<textarea onkeydown="calculateMaxLength('#nombre', MAX_NOMBRE_ATRACCION)" rows="1" id="nombre" path="nombre" name="nombre" class="atraction-box atraction-name-box"  placeholder="Ingrese el nombre de la atracci�n" required></textarea>
					</div>
					
					<div class="alert alert-warning fade in atraction-alert" id="mensajeNombreVacio" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> No se ha seleccionado un nombre para la atracci�n.
					</div>
					
					<div>
						<form:label class="atraction-label atraction-description-label" path="descripcion">Descripci�n</form:label>
					</div>
					<div>
						<textarea onkeydown="calculateMaxLength('#descripcion', MAX_DESCRIPCION_ATRACCION)" rows="4" id="descripcion" path="descripcion" name="descripcion" class="atraction-box atraction-descripcion-box"  placeholder="Ingrese la descripcion de la atracci�n" required></textarea>
					</div>
					
					<div class="alert alert-warning fade in atraction-alert" id="mensajeDescripcionVacia" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> No se ha seleccionado una descripci�n para la atracci�n.
					</div>
					
					<div>
						<form:label class="atraction-label atraction-schedule-label" path="horario">Horario</form:label>
					</div>
					<div>
						<textarea onkeydown="calculateMaxLength('#horario', MAX_HORARIO_ATRACCION)" rows="3" id="horario" path="horario" name="horario" class="atraction-box atraction-schedule-box"  placeholder="Ingrese el horario de la atracci�n"></textarea>
					</div>
					
					<div>
						<form:label class="atraction-label atraction-cost-label" path="precio">Precio</form:label>
					</div>
					<div>
						<textarea onkeydown="calculateMaxLength('#precio', MAX_PRECIO_ATRACCION)" rows="3" id="precio" path="precio" name="precio" class="atraction-box atraction-cost-box"  placeholder="Ingrese el costo de la atracci�n"></textarea>
					</div>
					
					<div>
						<form:label class="atraction-label atraction-recorrible-label" path="recorrible">&iquestEs recorrible?</form:label>
						  	<div>
							  	<input type="radio" id="es-recorrible" name="recorrible" path="recorrible" value="1" style="margin: 4px" onclick="$('#blueprints').show();">S�
							  	<input type="radio" id="no-es-recorrible" name="recorrible" path="recorrible" value="0" checked="checked" style="margin: 4px; margin-left: 15px;" onclick="$('#blueprints').hide();">No
							</div>
						</form>
					</div>
				</div>
			
				<!-- Plano -->
				<div class="atraction-blueprints-group">
					<!-- Plano -->
					<div id="blueprints" style="display: none;style="float:left"">
						<div>
							<form:label class="atraction-label atraction-blueprints-label" path="plano">Plano</form:label>
						</div>
						<div class="atraction-blueprints-box" style="float:left">
							<img id="plano" style="width:100%; height:100%">
							<button type="button" class="btn btn-default btn-sm atraction-get-blueprints" id="atraction-get-blueprints">
								<span class="glyphicon glyphicon-pencil"></span>
							</button>
							<input id="planoCambiado" name="planoCambiado" type="hidden" value="0">
							<input type="file" name="archivoPlano" id="archivoPlano"/>
						</div>
		
						<div class="alert-message">
							<div class="alert alert-warning fade in atraction-alert" id="mensajePlanoNecesario" style="display: none;">
							 	<a class="close" data-dismiss="alert" aria-label="close"></a>
							 	<strong>&iexclError!</strong> La atracci�n es recorrible. Debe proporcionarse un plano.
							</div>
							<div class="alert alert-warning fade in atraction-alert" id="mensajeImagenIncorrectaError" style="display: none;">
							 	<a class="close" data-dismiss="alert" aria-label="close"></a>
							 	<strong>&iexclError!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otra.
							</div>
						</div>
					</div>
					
					<!-- Galer�a -->
					<div>
						<div>
							<form:label class="atraction-label atraction-gallery-label" path="listaImagenes">Galer�a</form:label>
						</div>
						<div id ="container" class="atraction-gallery-box">
							<img class="atraction-gallery" id="imagenGaleria" style="width:100%; height:100%;">
							<video id="videoGaleria" style="width:100%; height:100%;display:none" controls >
							</video>
							<button type="button" class="w3-button w3-display-left atraction-gallery-slide-left" onclick="nextGalleryItem(-1)">&lt;</button>
							<button type="button" class="w3-button w3-display-right atraction-gallery-slide-right" onclick="nextGalleryItem(+1)">&#10095;</button>
							<input type="button" id="atraction-get-gallery-file" class="btn btn-default btn-atraction-get-gallery-file" value="+">
						    
						    <button type="button" class="btn btn-default btn-sm atraction-erase-multimedia" id="eliminarImagen">
								<span class="glyphicon glyphicon-erase"></span>
							 </button>
						</div>
					</div>
					<div class="alert alert-warning fade in atraction-alert" id="mensajeHayVideo" style="display: none;float:left">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> Ya se ha seleccionado un video anteriormente! Solo se puede seleccionar uno!
					</div>
					
					<div class="alert alert-warning fade in atraction-alert" id="mensajeCincoArchivos" style="display: none;float:left">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> Ya se han seleccionado 5 archivos, no se pueden agregar mas!
					</div>
					
					<div class="alert alert-warning fade in atraction-alert" id="mensajeTamanoImagen" style="display: none;float:left">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> La imagen no puede pesar mas de 50KB!
					</div>
					
					<div class="alert alert-warning fade in atraction-alert" id="mensajeTamanoVideo" style="display: none;float:left">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> El video no puede pesar mas de 10MB!
					</div>
					
					<div class="alert alert-warning fade in atraction-alert" id="mensajeUnaImagen" style="display: none;float:left">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> Tiene que estar presente una imagen por lo menos!
					</div>
					
					<!-- Audiogu�a -->
					<div class="new-atraction-audio-group">
						<form:label class="atraction-label atraction-audio-label" path="audioES">Audiogu�a</form:label>
						<div>
							<!-- Reproducir audiogu�a -->
							<div style="float:left">
								<audio id="audio" controls>
								    <source type="audio/mpeg">
								</audio> 
							</div>
							
							<!-- Bot�n agregar audiogu�a -->
							<div style="text-align:center; float:right;">
							
								<button type="button" class="btn btn-default btn-sm btn-atraction-get-audio-file" id="atraction-get-audio-file">
									<span class="glyphicon glyphicon-pencil"></span>
								 </button>
							
								<button type="button" class="btn btn-default btn-sm btn-atraction-erase-audio-file" id="atraction-erase-audio-file">
									<span class="glyphicon glyphicon-erase"></span>
								 </button>

								<input type="file" name="archivoAudioguia" id="archivoAudioguia"/>
							</div>
						</div>
					</div>
					
					<div class="alert alert-warning fade in atraction-alert-incorrect-audio" id="mensajeAudioIncorrectoError" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo seleccionado no es un audio v�lido. Por favor, introduzca otro.
					</div>
					
					<div class="alert alert-warning fade in atraction-alert-incorrect-audio" id="mensajeAudioTamano" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo pesa mas de 3MB. Por favor, seleccione uno de menor tama�o.
					</div>
					
				</div>
			</div>
			
			<!-- Bloque derecho -->
			<div class="atraction-right-block" style="float:right">
			
				<!-- Mapa -->
				<div>
					<input id="atraction-map-input" class="atraction-map-controls" type="text" placeholder="Ingresar ubicaci�n">
					<div id="atraction-map"></div> 
					
					<div class="alert alert-warning fade in atraction-alert-no-location" id="mensajeUbicacionVacia" style="display: none">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> No se ha seleccionado una ubicaci�n para la atracci�n.
					</div>
					
					<div class="alert alert-warning fade in atraction-alert-no-location" id="mensajeUbicacionLejana" style="display: none">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclAdvertencia!</strong> La atracci�n seleccionada est� a m�s de 15km de la ciudad actual.
					</div>	
				</div>
				
				<!-- Tabla puntos de inter�s y obras -->
				<div class="panel panel-primary view-atraction-panel">
					<div style="text-align:center">
						<input id="botonPuntosDeInteres" class="btn btn-ver-puntos-y-obras" type="button" value="Puntos de inter�s y obras" />
						
						<form class="form-horizontal maxwid" id="formAgregarPuntoDeInteres" name="formAgregarPuntoDeInteres" action="puntoDeInteresNuevo" method="post">
							<input id="botonAgregarPuntoDeInteres" class="btn btn-agregar-puntos-y-obras btn-nuevo-punto-de-interes" type="button" value="+" />
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
			</div>
		</div>
	
		<div class="alert alert-warning fade in atraction-alert-already-exists" id="mensajeNombreRepetido" style="display: none;">
		 	<a class="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>&iexclError!</strong> La atracci�n seleccionada ya se encuentra registrada. Seleccione otra.
		</div>	
	</form:form>

<form:form id="formAtras" action="ciudadVer?idCiudad=${atraccion.ciudad.id}" method="post"></form:form>
<div class="btn-final" style="text-align:center;">
	<input id="botonAtras" class="btn btn-default" type="button" value="Cancelar" />
	<input id="botonNuevo" class="btn btn-default btn-primary" type="button" value="Guardar" />
</div>


<!-- Definici�n de constantes -->
<script>
const MAX_NOMBRE_ATRACCION = "50";
const MAX_DESCRIPCION_ATRACCION = "250";
const MAX_HORARIO_ATRACCION = "50";
const MAX_PRECIO_ATRACCION = "50";

$("#nombre").attr("maxlength", MAX_NOMBRE_ATRACCION);
$("#descripcion").attr("maxlength", MAX_DESCRIPCION_ATRACCION);
$("#horario").attr("maxlength", MAX_HORARIO_ATRACCION);
$("#precio").attr("maxlength", MAX_PRECIO_ATRACCION);
</script>

<script>
$('#formNuevo').on('keyup keypress', function(e) {
  var keyCode = e.keyCode || e.which;
  if (keyCode === 13) { 
    e.preventDefault();
    return false;
  }
});

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

//Para validar si se ha o no elegido una ubicaci�n
var location_selected = false;

function validarPlano(plano, mensaje, hayError) {
	if ((document.getElementById(plano).src == "") && (!hayError)) {
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
	hayError = validarUbicacion(location_selected, "mensajeUbicacionVacia", hayError);
	
	if (document.getElementById('es-recorrible').checked) {
		hayError = validarPlano('plano', 'mensajePlanoNecesario', hayError);
	} else {
		document.getElementById("mensajePlanoNecesario").style.display = 'none';
	}
	
	if ((imageNumber == 0) && (!hayError)) {
		document.getElementById("mensajeUnaImagen").style.display = 'block';
		hayError = 1;
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


<!-- Para el slide de Galer�a podr�a ser �til -->
<script>

var imageNumber = 0;
var videoNumber = 0;

var filesNumber = imageNumber + videoNumber;

var multimedia = [];

var slideIndex = 0;

function nextGalleryItem(n) {
    showDivs(slideIndex += n);
}

function showDivs(n) {
    var i;
    if (n >= filesNumber) {slideIndex = 0}
    if (n < 0) {slideIndex = filesNumber - 1};
    if (multimedia.length == 0) {
    	document.getElementById('imagenGaleria').src = '';
    	hideGalleryVideo();
    	return;
    }
    multi = multimedia[slideIndex];
    if (multi.imagen == 1) {
		hideGalleryVideo();
		document.getElementById('imagenGaleria').src = multi.src;
	} else {
		hideGalleryImage();
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



/*--------Galer�a-----------*/

$(document).ready(function() {
	
	document.getElementById('eliminarImagen').onclick = function() {
		if (filesNumber == 0) {
			return;
		}
		unArchivo = multimedia[slideIndex];
		if (unArchivo.imagen == 1) {
			imageNumber -= 1;
		} else {
			videoNumber = 0;
			var eliminado = unArchivo.file;
			eliminado.parentNode.removeChild(eliminado);
		}
		filesNumber -= 1;
		var element = document.getElementById(unArchivo.id);
		element.parentNode.removeChild(element);
		multimedia.splice(slideIndex, 1);
		slideIndex -=1;
		filesNumber = imageNumber + videoNumber;
		nextGalleryItem(slideIndex);
	}
	
	
	document.getElementById('atraction-get-gallery-file').onclick = function() {
		input = document.createElement('input');
		input.type='file';
		input.id = 'archivoGaleria';
		container = document.getElementById("container");
		container.appendChild(input);
		document.getElementById('archivoGaleria').addEventListener('change', readURL, true);
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
	        	if (filesNumber == 5) {
	        		document.getElementById('mensajeCincoArchivos').style.display = 'block';
	        		elem = document.getElementById('archivoGaleria');
	        		elem.parentNode.removeChild(elem);
	        		return;
	        	}
	        	if (file.size > (50 * 1024)) {
	        		document.getElementById('mensajeTamanoImagen').style.display = 'block';
	        		elem = document.getElementById('archivoGaleria');
	        		elem.parentNode.removeChild(elem);
	        		return;
	        	}
	        	document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	        	document.getElementById('mensajeHayVideo').style.display = 'none';
	        	document.getElementById("mensajeUnaImagen").style.display = 'none';
	        	document.getElementById('mensajeTamanoImagen').style.display = 'none';
	        	tagImagen = document.createElement('img');
	        	imageVideo.file = tagImagen;
	        	document.getElementById('archivoGaleria').style.display = 'none';
	        	document.getElementById('archivoGaleria').name = 'archivoGaleria' + imageNumber;
				document.getElementById('archivoGaleria').id = 'archivoGaleria' + filesNumber;
				imageVideo.id = 'archivoGaleria' + filesNumber;
				imageNumber = imageNumber + 1;
	        	break;
	        case 'mp4': case 'avi': 
	        	if (videoNumber == 1) {
	        		document.getElementById('mensajeHayVideo').style.display = 'block';
	        		elem = document.getElementById('archivoGaleria');
	        		elem.parentNode.removeChild(elem);
	        		return;
	        	}
	        	if (filesNumber == 5) {
	        		document.getElementById('mensajeCincoArchivos').style.display = 'block';
	        		elem = document.getElementById('archivoGaleria');
	        		elem.parentNode.removeChild(elem);
	        		return;
	        	}
	        	if (file.size > (10 * 1024 * 1024)) {
	        		document.getElementById('mensajeTamanoVideo').style.display = 'block';
	        		elem = document.getElementById('archivoGaleria');
	        		elem.parentNode.removeChild(elem);
	        		return;
	        	}
	        	document.getElementById('mensajeHayVideo').style.display = 'none';
	        	isVideo = true;
	        	if (ext == 'mp4') {
	        		videoType='video/mp4';
	        	} else {
	        		videoType='video/avi';
	        	}
	        	document.getElementById('archivoGaleria').name = 'unVideo';
	        	document.getElementById('archivoGaleria').id = 'archivoGaleria' + filesNumber;
	        	imageVideo.id = 'archivoGaleria' + filesNumber;
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
			    imageVideo.file = source;
				video.appendChild(source);
			}
			multimedia.push(imageVideo);
			filesNumber = imageNumber + videoNumber;
			slideIndex = filesNumber - 1;
		}
		if(file) {
			reader.readAsDataURL(file);
		}
	}
});
</script>

<!-- Audiogu�a -->
<script>
$(document).ready(function() {
	document.getElementById('atraction-get-audio-file').onclick = function() {
		hideAllAtractionErrorMessages();
		document.getElementById('archivoAudioguia').addEventListener('change', readURL, true);
		var fileButton = document.getElementById('archivoAudioguia');
		fileButton.click();
	};
	
	$("#archivoAudioguia").change(function() {
	    var file = document.getElementById("archivoAudioguia").files[0];
	    var val = $(this).val();
	    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
	        case 'mp3':
	        	if (file.size > (3 * 1024 * 1024)) {
	        		document.getElementById('mensajeAudioTamano').style.display = 'block';
	        		document.getElementById('archivoAudioguia').value = "" ;
					document.getElementById('audio').src = "" ;
	        		return;
	        	}
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
        
        google.maps.event.addDomListener(input, 'keydown', function(e) { 
			if (e.keyCode == 13) { 
				e.preventDefault(); 
			}
		});

        var infowindow = new google.maps.InfoWindow();
        var marker = new google.maps.Marker({
            map: map,
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

		// Al clickear en el mapa, se guardan las coordenadas y se dibuja la ubicaci�n
        google.maps.event.addListener(map, 'click', function( event ){
       		marker.setVisible(false);
       		marker.setPosition(event.latLng);
            marker.setVisible(true);

			// Se guardan las coordenadas
       	  	document.formNuevo.latitud.value = event.latLng.lat();
           	document.formNuevo.longitud.value = event.latLng.lng();
           	location_selected = true;

           	// Se verifica si la ubicaci�n seleccionada se encuentra a m�s de 15km.
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
<!-- Google Key AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="../template/importacion.jsp"></jsp:include>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trips - Nueva ciudad</title>
</head>
<body>

	<h1 class="page-header">Nueva ciudad</h1>

	<form:form class="form-horizontal maxwid" id ="formNuevo" name="formNuevo" action="ciudadNuevoValidar" method="post" commandName="ciudad" enctype="multipart/form-data">
		<div class="input-and-image-group" style="width: 100%; overflow: hidden;">	
			<div class="input" style="float:left">
				<div class="name-group">
					<form:label class="name-label" path="nombre">Nombre de la ciudad</form:label>
				    <form:input id="city" class="name-box" type="text" path="nombre" required="required" placeholder="Ingrese el nombre de la ciudad"/>
					
					<form:input id="pais" type="hidden" name="pais" path="pais"/>
					<form:input id="latitud" type="hidden" name="latitud" path="latitud"/>
					<form:input id="longitud" type="hidden" name="longitud" path="longitud"/>
				</div>
				
				<div class="image-group">
					<div class="image-box" style="float:right" id="zonaArrastrable">
						<img id="imagen" style="width:100%; height:100%">
					</div>
					
					<div class="button-message-group" style="float:left">
						<div class="image-route" style="float:up">
							<input type="button" id="get_file" class="btn-get-file" value="Agregar imagen">
					        
					        <input type="file" name="archivoImagenPiso" id="archivoImagenPiso"/>
						</div>
						<div class="image-label" style="float:down">Se recomienda usar una imagen con resolución 30x80 u otra de similar escala</div>
					</div>
					
					<div class="alert-message">
						<div class="alert alert-warning fade in" id="mensajeImagenIncorrectaError" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>Error!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otra.
						</div>
						
						<div class="alert alert-warning fade in" id="mensajeNombreRepetido" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>Error!</strong> La ciudad seleccionada ya se encuentra registrada, seleccione otra.
						</div>
						
						<div class="alert alert-warning fade in" id="mensajeNombreVacio" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>Error!</strong> No se ha seleccionado ninguna ciudad.
						</div>
					</div>
				</div>
			</div>
			
		    <div id="map" style="float:right"></div>  
		</div>
	</form:form>
	
<form:form id="formAtras" action="ciudades" method="post"></form:form>
<div class="btn-final" style="text-align:center;">
	<input id="botonAtras" class="btn btn-default" type="button" value="Cancelar" />
	<input id="botonNuevo" class="btn btn-default" type="button" value="Guardar" />
</div>
<div class="wait"></div>
	
	<style type="text/css">
		html {
  			font-size: 10px;
		}
		
		.page-header {
			 margin-left: 2rem;
		}
		
		.input-and-image-group {
			margin-left: 8rem;
		}
		
		.name-group {
			margin-top: 3rem;
		}
		
		.name-label {
			margin-left: 2rem;
			width: 15rem;
		}
		
		.name-box {
			margin-top: 0.5rem;
			height: 2.5rem;
			width: 50rem;
		}
		
		.input {
			margin-top: 0.5rem;
			margin-left: 10rem;
		}
		
		.image-group {
			margin-top: 3rem;
			display: inline-block;	
    		vertical-align: top;
		}
		
		.image-label {
			margin-left: 2.3rem;
			margin-top: 2rem;
			width: 12.1rem;
			font-weight: bold;
			text-align: center;
		}
		
		.image-box {
			margin-left: 3rem;
			height: 18.75rem;
			width: 50rem;
			background-color: #909090;
		}
		
		.image-route {
			margin-top: 0.5rem;
			height: 2.5rem;
			width: 10rem;
		}
		
		#map {
			margin-top: 3rem;
			margin-right: 25rem;
		    width: 27rem;
		    height: 27rem;
		}
		
		.btn-get-file {
			margin-left: 1.8rem;
			margin-top: 1rem;
			margin-bottom: 1rem;
			width: 14rem;
			height: 2.55rem;
		}
		
		.btn-final {
			margin-top: 1rem;
			margin-bottom: 1rem;
		}
		
		.alert-message{ 
			margin-top: 20rem;
		}
	</style>
	
<script>
	function setValue(id, new_value) {
		  var s = document.getElementById(id);
		  s.innerHTML = new_value;
	}
	
	$('#botonAtras').on('click', function(e) {
		e.preventDefault();
		document.getElementById("formAtras").submit();
	});
	
	$('#botonNuevo').on('click', function(e) {
		e.preventDefault();
		document.getElementById("mensajeNombreRepetido").style.display = 'none';
		var city = {
			name: document.getElementById('city').value,
			country: "Desconocido"
		};
		var geocoder = new google.maps.Geocoder();
		parseCity(city);
		document.formNuevo.nombre.value = city.name;
		document.formNuevo.pais.value = city.country;
		validarCiudadRepetida();
	});
	
	function validarCiudadRepetida() {
		hayError = 0;
		if (document.getElementById('archivoImagenPiso').value == '') {
			document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
			hayError = 1;
		} else {
			document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
		}
		if (document.getElementById('city').value == '') {
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
			"pais": document.formNuevo.pais.value,
			"latitud": document.formNuevo.latitud.value,
			"longitud": document.formNuevo.longitud.value
		};
		$.ajax({
			url : "validarCiudad",
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
	
	function parseCity(city) {
		var complete_city = city.name;
		var n = complete_city.lastIndexOf(", ");
		if ((n > 1) && (n < complete_city.length)) {
			city.name = complete_city.substring(0, n);
			city.country = complete_city.substring(n + 2, complete_city.length);
		}
	}
</script>

<!-- Imagen -->

<script>
$(document).ready(function() {
	$('#formNuevo').on('keyup keypress', function(e) {
	  var keyCode = e.keyCode || e.which;
	  if (keyCode === 13) { 
	    e.preventDefault();
	    return false;
	  }
	});
	
	document.getElementById('get_file').onclick = function() {
		document.getElementById('archivoImagenPiso').addEventListener('change', readURL, true);
		var fileButton = document.getElementById('archivoImagenPiso');
		fileButton.click();
	};
	
	$("#archivoImagenPiso").change(function() {
	    var val = $(this).val();
	    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
	        case 'gif': case 'jpg': case 'png':
	        	document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	        	break;
	        default:
	            $(this).val('');
				document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
				document.getElementById('archivoImagenPiso').value = "" ;
				document.getElementById('imagen').src = "" ;
				break;
	    }
	});
	
	function readURL(){
		var file = document.getElementById("archivoImagenPiso").files[0];
		var reader = new FileReader();
	    reader.onloadend = function(){
			document.getElementById('imagen').src = reader.result;
		}
		if(file) {
			reader.readAsDataURL(file);
		} 
	}
	
	$('#formNuevo').on('keyup keypress', function(e) {
	  var keyCode = e.keyCode || e.which;
	  if (keyCode === 13) { 
	    e.preventDefault();
	    return false;
	  }
	});
	
});
</script>

<!-- Maps -->
<script>
    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: -34.6036844, lng: -58.3815591}, //Buenos Aires coordinates
            zoom: 13
        });
        var input = (document.getElementById('city'));

        var autocomplete = new google.maps.places.Autocomplete(input, {types: ['(cities)']});
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
    }
    </script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places&callback=initMap" async defer></script>

</body>
</html>
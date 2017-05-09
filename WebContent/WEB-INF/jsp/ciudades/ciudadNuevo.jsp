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

	<h1 class="page-header" style="margin-left:5rem">Nueva ciudad</h1>

	<form:form id ="formNuevo" name="formNuevo" action="ciudadNuevoValidar" method="post" commandName="ciudad" enctype="multipart/form-data">
		<div class="input-and-image-group" style="width: 100%; overflow: hidden;">	
			<div class="input" style="float:left">
				<div class="name-group">
					<div>
						<form:label class="name-label" path="nombre">Nombre<font color="red"> *</font></form:label>
					    <form:input id="city" maxlength="50" class="name-box" type="text" path="nombre" required="required" placeholder="Ingrese el nombre de la ciudad"/>
					</div>
					
					<div>
						<form:label class="name-label" path="pais">País<font color="red"> *</font></form:label>
						<form:input id="pais" maxlength="50" class="name-box" type="text" name="pais" path="pais" required="required" placeholder="Ingrese el país al que pertenece"/>
					</div>
					
					<form:input id="latitud" type="hidden" name="latitud" path="latitud"/>
					<form:input id="longitud" type="hidden" name="longitud" path="longitud"/>
				</div>
				
				<div class="image-group" style="width:100%; height:100%; overflow: auto;">
					<div class="button-message-group" style="float:left">
						<label class="name-label">Imagen<font color="red"> *</font></label>
					</div>
					
					<div class="image-box" style="float:right" id="zonaArrastrable">
						<img id="imagen" style="width:100%; height:100%">
						<button type="button" class="btn btn-default btn-sm get_file" id="get_file">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
				        <input type="file" name="archivoImagenPiso" id="archivoImagenPiso"/>
					</div>
		
					<div class="alert-message">
						<div style="margin-bottom: 2rem;">
							<font style="margin-left: 18rem; font-weight: bold;" size="2">Se recomienda emplear una imagen de resolución 800x300 o de escala similar</font>
						</div>
						<div class="alert alert-danger fade in new-city-alert-message" id="mensajeImagenIncorrectaError" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>¡Error!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otra.
						</div>
						
						<div class="alert alert-danger fade in new-city-alert-message" id="mensajeNombreRepetido" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>¡Error!</strong> La ciudad seleccionada ya se encuentra registrada, seleccione otra.
						</div>
						
						<div class="alert alert-danger fade in new-city-alert-message" id="mensajeNombreVacio" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>¡Error!</strong> No se ha seleccionado ninguna ciudad.
						</div>
						
						<div class="alert alert-danger fade in new-city-alert-message" id="mensajePaisVacio" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>¡Error!</strong> No se ha seleccionado ningún país.
						</div>
						
						<div class="alert alert-danger fade in new-city-alert-message" id="mensajeUbicacionVacia" style="display: none">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado una ubicación para la atracción.
						</div>
				
						<div class="alert alert-danger fade in new-city-alert-message" id="mensajeNombreIncorrecto" style="display: none;">
 						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
 						 	<strong>¡Error!</strong> La ciudad seleccionada es incorecta.
 						</div>

 						<font style="margin-left: 18rem;" color="red" size="1">Los campos indicados con * son obligatorios</font>
					</div>
				</div>
			</div>
			
		    <div id="map" class="map-new-city" style="float:right"></div>  
		</div>
	</form:form>
	
<form:form id="formAtras" action="ciudades" method="post"></form:form>
<div class="btn-final" style="text-align:center;">
	<input id="botonAtras" class="btn btn-default" type="button" value="Cancelar" />
	<input id="botonNuevo" class="btn btn-default btn-primary" type="button" value="Guardar" />
</div>
<div class="wait"></div>
	
<script>
	var location_selected = false;

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
		document.getElementById("mensajeNombreIncorrecto").style.display = 'none';
		var city = {
				all: document.getElementById('city').value,
			};
			var geocoder = new google.maps.Geocoder();
			geocoder.geocode({'address': city.name}, function(results, status) {
	 	   	    if (status === google.maps.GeocoderStatus.OK && results.length > 0) {
	 				validarCiudadRepetida(city.all);
	 	       	} else {
	 	       		document.getElementById("mensajeNombreIncorrecto").style.display = 'block';
	 	       		return;
	 	       	}
	 	    });
	});
	
	function validarCiudadRepetida(city) {
		hayError = 0;
		if ((document.getElementById('archivoImagenPiso').value == '') && (!hayError)) {
			document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
			hayError = 1;
		} else {
			document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
		}
		if ((document.getElementById('city').value == '') && (!hayError)) {
			document.getElementById("mensajeNombreVacio").style.display = 'block';
			hayError = 1;
		} else {
			document.getElementById("mensajeNombreVacio").style.display = 'none';
		}
		if ((document.getElementById('pais').value == '') && (!hayError)) {
			document.getElementById("mensajePaisVacio").style.display = 'block';
			hayError = 1;
		} else {
			document.getElementById("mensajePaisVacio").style.display = 'none';
		}

		if ((!location_selected) && (!hayError)) {
 	    	document.getElementById("mensajeUbicacionVacia").style.display = 'block';
 	       	hayError = 1;
       	} else {
       		document.getElementById("mensajeUbicacionVacia").style.display = 'none';
        }
		
		if (hayError == 1) {
			document.formNuevo.city.value = city;
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
		var n = city.all.lastIndexOf(", ");
		if ((n > 1) && (n < city.all.length)) {
			city.name = city.all.substring(0, n);
			city.country = city.all.substring(n + 2, city.all.length);
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

	validateImage('get_file', 'archivoImagenPiso', 'imagen', "mensajeImagenIncorrectaError");
	
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

           	var city = {
       			all: document.getElementById('city').value,
       			name: document.getElementById('city').value,
       			country: "Desconocido"
       		};
       		var geocoder = new google.maps.Geocoder();
       		geocoder.language
       		geocoder.geocode({'address': city.name}, function(results, status) {
       	   	    if (status === google.maps.GeocoderStatus.OK && results.length > 0) {
       	       	    parseCity(city);
       				document.formNuevo.nombre.value = city.name;
       				document.formNuevo.pais.value = city.country;
       	       	}
       	    });   
        });
    }
    </script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places&callback=initMap&language=es" async defer></script>

</body>
</html>
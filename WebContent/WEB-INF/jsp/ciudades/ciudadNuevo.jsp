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
<title>Ciudad nueva</title>
</head>
<body>

<h1 class="page-header">Ciudad nueva</h1>

<div>
	<input type="button" id="get_file" class="btn btn-default" value="Elegir imagen">
</div>

<form:form class="form-horizontal maxwid" id ="formNuevo" action="ciudadNuevoValidar" method="post" commandName="ciudad" enctype="multipart/form-data">
	<div class="form-group">
		<form:label class="control-label col-sm-2" path="nombre">Nombre:</form:label>
	    <div class="col-sm-10">
			<form:input class="form-control" id="nombre" path="nombre" required="required"/>
		</div>
		<input id="pac-input" class="controls" type="text" placeholder="Enter a location">
		
		<input type="file" name="archivoImagenPiso" id="archivoImagenPiso"/>
		
		<div class="cuadrado" id="zonaArrastrable">
			<img id="imagen">
		</div>
        
        <div id="map"></div>
		
	</div>

</form:form>

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

<form:form id="formAtras" action="ciudades" method="post">
	<input id="url" type="hidden" name="url" />	
</form:form>
<div class="form-group">
    <div >
		<input id="botonAtras" class="btn btn-default" type="button" value="Atras" />
		<input id="botonNuevo" class="btn btn-default" type="button" value="Guardar"/>
	</div>
</div>
<div class="wait"></div>

<script>

$('#botonAtras').on('click', function(e) {
	e.preventDefault();
	var url = document.URL;
	document.getElementById("url").value = url;
	document.getElementById("formAtras").submit();
});

$('#botonNuevo').on('click', function(e) {
	e.preventDefault();
	hayError = 0;
	document.getElementById("mensajeNombreRepetido").style.display = 'none';
	if (document.getElementById('archivoImagenPiso').value == '') {
		document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	}
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
		"nombre" : document.getElementById("nombre").value,
		"pais": "Pais"
	};
	console.log("JSON");
	console.log(json);
	console.log(JSON.stringify(json));
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
	
});

</script>

<!-- Imagen -->

<script>
$(document).ready(function() {
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
			document.getElementById('imagen').src = reader.result ;        
			}
		if(file){
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

<script>
    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: -34.6036844, lng: -58.3815591}, //Buenos Aires coordinates
            zoom: 13
        });
        var input = (document.getElementById('pac-input'));
        
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

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
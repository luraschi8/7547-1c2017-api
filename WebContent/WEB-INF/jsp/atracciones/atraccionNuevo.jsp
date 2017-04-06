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
						<div>
							<form:label class="atraction-label atraction-name-label" path="nombre">Nombre</form:label>
						</div>
						<div>
						    <form:input id="atraction-name" class="atraction-box atraction-name-box" type="text" path="nombre" required="required" placeholder="Ingrese el nombre de la atracción"/>
						</div>
						
						<div>
							<form:label class="atraction-label atraction-description-label" path="descripcion">Descripción</form:label>
						</div>
						<div>
						    <form:input id="atraction-description" class="atraction-box atraction-description-box" type="text" path="descripcion" required="required" placeholder="Ingrese la descripción de la atracción"/>
						</div>
						
						<div>
							<form:label class="atraction-label atraction-schedule-label" path="horario">Horario</form:label>
						</div>
						<div>
							<form:input id="atraction-schedule" class="atraction-box atraction-schedule-box" type="text" path="horario" placeholder="Ingrese el horario de visita de la atracción"/>
						</div>
						
						<div>
							<form:label class="atraction-label atraction-cost-label" path="precio">Precio</form:label>
						</div>
						<div>
							<form:input id="atraction-cost" class="atraction-box atraction-cost-box" type="text" path="precio" placeholder="Ingrese el costo de la atracción"/>
						</div>
						
						
						<div>
							<form:label class="atraction-label atraction-recorrible-label" path="recorrible">&iquestEs recorrible?</form:label>
							  	<div>
								  	<input type="radio" name="recorrible" path="recorrible" value="si">Sí
								  	<input type="radio" name="recorrible" path="recorrible" value="female" checked="checked">No
								</div>
							</form>
						</div>
					</div>
					
					<!-- Mapa -->
					<input id="atraction-map-input" class="atraction-map-controls" type="text" placeholder="Ingresar ubicación">
       		 		<div id="atraction-map"></div>

					<!-- <div id="map" class="map-new-city" style="float:right"></div>   -->
				</div>
				
				
				
				<!-- Plano y tabla -->
				<div class="atraction-bluprints-and-chart" style="width: 100%; overflow: hidden;">
				
					<!-- Plano -->
					<div class="atraction-blueprints-group" style="float:left">
						<div>
							<form:label class="atraction-label atraction-blueprints-label" path="plano">Plano</form:label>
						</div>
						<div class="atraction-blueprints-box" style="float:left">
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
							 	<strong>Error!</strong> La atracción seleccionada ya se encuentra registrada, seleccione otra.
							</div>
							
							<div class="alert alert-warning fade in" id="mensajeNombreVacio" style="display: none;">
							 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
							 	<strong>Error!</strong> No se ha seleccionado un nombre para la atracción.
							</div>
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
				
			</div>
		</form:form>
		
		<div class="btn-final" style="text-align:center;">
			<input id="botonAtras" class="btn btn-default" type="button" value="Cancelar" />
			<input id="botonNuevo" class="btn btn-default" type="button" value="Guardar" />
		</div>
		
		
		
		<!-- Mapa -->
		<script>
		    function initMap() {
		        var map = new google.maps.Map(document.getElementById('atraction-map'), {
		            center: {lat: -34.6036844, lng: -58.3815591}, //Buenos Aires coordinates
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
		
        
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places&callback=initMap&language=es" async defer></script>
        
	</body>
</html>
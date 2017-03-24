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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/maps.css" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ciudad nueva</title>
</head>
<body>

<h1 class="page-header">Ciudad nueva</h1>

<form:form class="form-horizontal maxwid" id ="formNuevo" action="ciudadNuevoValidar" method="post" commandName="ciudad">
	<div class="form-group">
		<form:label class="control-label col-sm-2" path="nombre">Nombre:</form:label>
	    <div class="col-sm-10">
			<form:input class="form-control" id="nombre" path="nombre" required="required"/>
		</div>
		<input id="pac-input" class="controls" type="text" placeholder="Enter a location">
        
        <div id="map"></div>
		
	</div>

</form:form>
<c:if test="${!empty listaErrores}"> 
	<div id="errores" class="alert alert-warning fade in" style="display:block;">
		<c:forEach items="${listaErrores}" var="error"> 
			<c:out value="${error}"> </c:out>
			<br>
		</c:forEach>
	</div>
</c:if>

<form:form id="formAtras" action="ciudades" method="post">
	<input id="url" type="hidden" name="url" />	
</form:form>
<div class="form-group">
    <div >
		<input id="botonAtras" class="btn btn-default" type="button" value="Atras" />
		<input id="botonNuevo" class="btn btn-default" type="button" value="Guardar" />
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
	document.getElementById("formNuevo").submit();
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
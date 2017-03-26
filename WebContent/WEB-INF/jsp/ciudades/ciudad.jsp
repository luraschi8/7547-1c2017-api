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

<title>Ciudad</title>

</head>
<body>
<h1 class="page-header">
	Ciudad
</h1>
<div class="panel-group">
	<div class="panel panel-primary">
		<img src="/Trips/imagenCiudad?id=${ciudad.id}"/>
	</div>
</div>
<div class="panel-group">
	<div id="map"></div>
	<div class="panel panel-primary">
		<div class="panel-body">
			<table id="tablita" class="display order-column" cellspacing="0" width="100%">
				<thead>
					<tr>
						<th>Nombre</th>
						<th></th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
	</div>
</div>

<c:set var="borrar">
	Borrar
</c:set>

<c:set var="ver">
	Ver
</c:set>

<c:set var="id">
	${ciudad.id}
</c:set>

<script>

//$(document).ready(function() {
   	var map;

	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
		    center: {lat: -34.6036844, lng: -58.3815591}, //Buenos Aires coordinates
		    zoom: 13
		});
	}
   
    var table = $('#tablita').DataTable( {
		dom: 'frtip',
		ajax: "atraccionesCiudadJson/${id}",
	    columns: [
	        {data: "nombre" },
	        {defaultContent:'<button class="btn btn-danger" id="borrar">${borrar}</button>'},
	        {defaultContent:'<button class="btn btn-warning" id="ver">${ver}</button>'}
	        ],
	    select:true,
	    paging:false,
	    pageLength:50,
	    ordering:true,
	    bFilter: false
	});
	
	$('#tablita tbody').on('click', '#ver', function (e) {
		var data = table.row(this.closest("tr")).data();
		e.preventDefault();
		var latitud = data["latitud"];
		var longitud = data["longitud"];
		var myLatlng = new google.maps.LatLng(latitud,longitud);
		var marker = new google.maps.Marker({
          position: myLatlng,
          title: 'Hello World!'
        });
        marker.setMap(map);
		map.setCenter(marker.getPosition());
	});
//});

</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places&callback=initMap" async defer></script>

</body>
</html>
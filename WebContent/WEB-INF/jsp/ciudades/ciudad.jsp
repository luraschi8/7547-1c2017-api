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

<title>Trips - ${ciudad.nombre}</title>

</head>

<body>

<form:form class="form-horizontal maxwid" id ="formModificar" name="formModificar" action="ciudadModificar" method="post" commandName="ciudad" enctype="multipart/form-data">
	<form:input id="id" type="hidden" name="id" path="id" value="${ciudad.id}"/>


	<input type="file" name="archivoImagenPiso" id="archivoImagenPiso"/>
	<input id="imagenCambiada" name="imagenCambiada" type="hidden" value="0">
	
	<div class="view-city-image">
		<div class="panel panel-primary view-city-image-box sobreBoton">
			<img id="imagen" src="${pageContext.request.contextPath}/imagenCiudad?id=${ciudad.id}" style="width:100%; height:100%"/>
           	<input type="button" id="get_file" class="btn btn-default btn-get-file" value="Editar">
		</div>
	</div>
	
	<div class="alert-message">
		<div class="alert alert-warning fade in" id="mensajeImagenIncorrectaError" style="display: none;">
		 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>Error!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otra.
		</div>
	</div>
</form:form>

<h1 class="page-header">
	${ciudad.nombre} , ${ciudad.pais}
</h1>

<div class="panel-group" style="width: 100%; overflow: hidden;">
	<div id="map" class="view-city-map" style="float:left"></div>
	<div class="panel panel-primary view-city-panel" style="float:right">
		<div class="panel-body">
			<table id="tablita" class="display order-column view-city-board" cellspacing="0" width="100%">
				<thead>
					<tr>
						<th></th>
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

<form:form id="formAtras" action="ciudades" method="post"></form:form>
<div class="view-city-btn-final" style="text-align:center;">
	<input id="botonAtras" class="btn btn-default" type="button" value="Cancelar" />
	<input id="botonNuevo" class="btn btn-default" type="button" value="Guardar" />
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

<c:set var="latitud">
	${ciudad.latitud}
</c:set>

<c:set var="longitud">
	${ciudad.longitud}
</c:set>

<script>

//$(document).ready(function() {
var map;
var markers = [];

function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
	    center: {lat: ${latitud}, lng: ${longitud}}, //Buenos Aires coordinates
	    zoom: 13
	});
};
  
var table = $('#tablita').DataTable( {
	dom: 'frtip',
	ajax: "atraccionesCiudadJson/${id}",
    columns: [
        {	data: "id",
        	render: function (data,type,row) {
        		return '<div align="center"><img src="/Trips/imagenAtraccion?id=' + data + '" style="align: center; width:40px; height:40px"/></div'
        	}
        },
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
	for (var i = 0; i < markers.length; i++) {
		pos = markers[i].getPosition();
		if (pos.lat() == myLatlng.lat() && pos.lng() == myLatlng.lng()) {
			markers[i].setMap(null);
			markers.splice(i,1);
			return;
		}
	}
	var marker = new google.maps.Marker({
         position: myLatlng,
         title: 'Hello World!'
       });
       marker.setMap(map);
	map.setCenter(marker.getPosition());
	markers.push(marker);
});

$('#botonNuevo').on('click', function(e) {
	e.preventDefault();
	hayError = 0;
	if (document.getElementById("imagenCambiada").value == "1" && document.getElementById('archivoImagenPiso').value == '') {
		document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	}
	if (hayError == 1) {
		return;
	}
	document.getElementById("formModificar").submit();
});

$('#botonAtras').on('click', function(e) {
	e.preventDefault();
	document.getElementById("formAtras").submit();
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
	        case 'gif': case 'jpg': case 'png': case 'jpeg': case 'bmp': 
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
		document.getElementById("imagenCambiada").value = "1";
		var file = document.getElementById("archivoImagenPiso").files[0];
		var reader = new FileReader();
	    reader.onloadend = function(){
			document.getElementById('imagen').src = reader.result ;        
			}
		if(file){
			reader.readAsDataURL(file);
		} 
	}
});
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places&callback=initMap" async defer></script>

</body>
</html>
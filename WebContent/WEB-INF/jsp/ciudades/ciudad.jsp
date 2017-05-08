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

<form:form class="form-horizontal" id ="formModificar" name="formModificar" action="ciudadModificar" method="post" commandName="ciudad" enctype="multipart/form-data">
	<form:input id="id" type="hidden" name="id" path="id" value="${ciudad.id}"/>


	<input type="file" name="archivoImagenPiso" id="archivoImagenPiso"/>
	<input id="imagenCambiada" name="imagenCambiada" type="hidden" value="0">
	
	<div style="width: 100%; height: 100%">
		<div class="view-city-image-box sobreBoton">
			<img id="imagen" src="${pageContext.request.contextPath}/imagenCiudad?id=${ciudad.id}" style="width:100%; height:100%"/>
			<button type="button" class="btn btn-default btn-sm btn-get-file" id="get_file" onclick="editCoordinates()">
				<span class="glyphicon glyphicon-pencil"></span>
			</button>
		</div>
	</div>
	
	<div>
		<div class="alert alert-danger fade in view-city-wrong-image" id="mensajeImagenIncorrectaError" style="display: none;">
		 	<a class="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>¡Error!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otro.
		</div>
	</div>
</form:form>

<div class="view-city-information-block">
	<h1 class="view-city-page-header">
		${ciudad.nombre}, ${ciudad.pais}
	</h1>
	
	<div class="panel-group">
		<div id="view-city-map" class="view-city-map" style="margin-left: 3%;"></div>
		
		<div class="panel panel-primary view-city-panel">
			<div class="city-panel-buttons">
				<input id="botonAtracciones" class="btn btn-ver" type="button" value="Atracciones"/>
				<input id="botonAgregarAtraccion" class="btn btn-agregar btn-nueva-atraccion" type="button" value="+"/>
				<input id="botonRecorridos" class="btn btn-ver" type="button" value="Recorridos"/>
				<input id="botonAgregarRecorrido" class="btn btn-agregar" type="button" value="+"/>
			</div>
		
			<div class="panel-body atractions_panel_body">
				<table id="tablita" class="display order-column view-city-board" cellspacing="0">
					<thead>
						<tr>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
				
			<div class="panel-body routes_panel_body" style="display: none;">
				<table id="route_table" class="order-column view-city-board" cellspacing="0">
					<thead>
						<tr>
							<th></th> <!-- Nombre -->
							<th></th> <!-- Cantidad paradas -->
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


<form style="display: none" class="form-city-add-atraction" id="formAgregarAtraccion" name="formAgregarAtraccion" action="atraccionNuevo" method="post">
	<input id="idCiudad" name="idCiudad" type="hidden" value="${ciudad.id}"/>
	<input id="latitudCiudad" name="latitudCiudad" type="hidden" value="${ciudad.latitud}"/>
	<input id="longitudCiudad" name="longitudCiudad" type="hidden" value="${ciudad.longitud}"/>
</form>

<form:form id="formAtras" action="ciudades" method="post"></form:form>
<div class="view-city-btn-final" style="text-align:center;">
	<input id="botonAtras" class="btn btn-default" type="button" value="Atrás" />
	<input id="botonNuevo" class="btn btn-default btn-primary" type="button" value="Aceptar" />
</div>

<form style="display: none" class="form_city_add_route" id="formAgregarRecorrido" name="formAgregarRecorrido" action="recorridoNuevo" method="post">
	<input id="idCiudad" name="idCiudad" type="hidden" value="${ciudad.id}"/>
	<input id="latitudCiudad" name="latitudCiudad" type="hidden" value="${ciudad.latitud}"/>
	<input id="longitudCiudad" name="longitudCiudad" type="hidden" value="${ciudad.longitud}"/>
</form>

<c:set var="borrar">
	Borrar
</c:set>

<c:set var="value">
 	Se borrará la atracción junto a todo el contenido asociado a la misma. ¿Desea continuar?
</c:set>
<input id="mensajeBorrar" type="hidden" value="${value}" />
 
<form id ="formBorrar" name="formBorrar" action="atraccionBorrar" method="post">
	<input id="idAtraccion" name="idAtraccion" type="hidden">
	<input id="idCiudadAtraccion" name="idCiudadAtraccion" value="${ciudad.id}" type="hidden"> 
</form>

<c:set var="msg_delete_route">
 	Se borrará el recorrido junto a todo el contenido asociado al mismo. ¿Desea continuar?
</c:set>
<input id="mensajeBorrarRecorrido" type="hidden" value="${msg_delete_route}" />
 
<form id ="formBorrarRecorrido" name="formBorrarRecorrido" action="recorridoBorrar" method="post">
	<input id="idRecorrido" name="idRecorrido" type="hidden">
	<input id="idCiudadRecorrido" name="idCiudadRecorrido" value="${ciudad.id}" type="hidden"> 
</form>

<c:set var="ver">
	Ver
</c:set>

<form:form id="formVer" name="formVer" action="atraccionVer" method="get" commandName="atraccion">
	<input id="idAtraccion" name="idAtraccion" type="hidden"/>
</form:form>

<form:form id="formVerRecorrido" name="formVerRecorrido" action="recorridoVer" method="get" commandName="recorrido">
	<input id="idRecorrido" name="idRecorrido" type="hidden"/>
</form:form>

<c:set var="marcar">
	Marcar
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
var map;
var markers = [];

function initMap() {
	map = new google.maps.Map(document.getElementById('view-city-map'), {
	    center: {lat: ${latitud}, lng: ${longitud}},
	    zoom: 13
	});
};
  
var table = $('#tablita').DataTable( {
	dom: 'frtip',
	ajax: "atraccionesCiudadJson/${id}/EN",
    columns: [
        {	data: "id",
        	render: function (data,type,row) {
        		return '<div align="center"><img src="${pageContext.request.contextPath}/imagenPrincipalAtraccion?id=' + data + '" style="align: center; width:40px; height:40px"/></div'
        	}
        },
        {data: "nombre" },
        {defaultContent:'<button class="btn btn-danger" id="borrar">${borrar}</button>'},
        {defaultContent:'<button class="btn btn-warning" id="ver">${ver}</button>'},
        {defaultContent:'<button class="btn btn-info" id="marcar">${marcar}</button>'}
        ],
    select:true,
    paging:false,
    pageLength:50,
    ordering:true,
    bFilter: false
});

$('#tablita tbody').on('click', '#marcar', function (e) {
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
         position: myLatlng
       });
       marker.setMap(map);
	map.setCenter(marker.getPosition());
	markers.push(marker);
});

$('#tablita tbody').on('click', '#borrar', function (e) {
	var data = table.row(this.closest("tr")).data();
	var id = data["id"];
	var mensaje = document.getElementById("mensajeBorrar").value;
	e.preventDefault();
	bootbox.confirm(mensaje, function (response) {
		if (response) {
			document.formBorrar.idAtraccion.value = id;
			document.getElementById("formBorrar").submit();
		}
	});
});

$('#tablita tbody').on('click', '#ver', function (e) {
	var data = table.row(this.closest("tr")).data();
	e.preventDefault();
	document.formVer.idAtraccion.value = data["id"];
	document.getElementById("formVer").submit();
});

$('#botonNuevo').on('click', function(e) {
	e.preventDefault();
	hayError = 0;
	if (document.getElementById("imagenCambiada").value == "1" && document.getElementById('archivoImagenPiso').value == '') {
		document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
		$('.form-horizontal').css('margin-bottom', '8rem');
		hayError = 1;
	} else {
		document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
		$('.form-horizontal').css('margin-bottom', '0');
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

$('#botonAgregarAtraccion').on('click', function(e) {
	e.preventDefault();
	document.getElementById("formAgregarAtraccion").submit();
});

$('#botonAgregarRecorrido').on('click', function(e) {
	e.preventDefault();
	document.getElementById("formAgregarRecorrido").submit();
});

$('#botonAtracciones').on('click', function(e) {
	e.preventDefault();
	document.getElementsByClassName("atractions_panel_body")[0].style.display = "none";
	document.getElementsByClassName("routes_panel_body")[0].style.display = "block";
});

$('#botonRecorridos').on('click', function(e) {
	e.preventDefault();
	document.getElementsByClassName("routes_panel_body")[0].style.display = "none";
	document.getElementsByClassName("atractions_panel_body")[0].style.display = "block";
});

var route_table = $('#route_table').DataTable( {
	dom: 'frtip',
	ajax: "recorridosCiudadJson/${id}",
    columns: [
    	{data: "nombre"},
        {data: "cantAtracciones"},
        {defaultContent:'<button class="btn btn-danger" id="borrarRecorrido">${borrar}</button>'},
        {defaultContent:'<button class="btn btn-warning" id="verRecorrido">${ver}</button>'},
        ],
    select:true,
    paging:false,
    pageLength:50,
    ordering:true,
    bFilter: false
});

$('#route_table tbody').on('click', '#borrarRecorrido', function (e) {
	var data = route_table.row(this.closest("tr")).data();
	var id = data["id"];
	var mensaje = document.getElementById("mensajeBorrarRecorrido").value;
	e.preventDefault();
	bootbox.confirm(mensaje, function (response) {
		if (response) {
			document.formBorrarRecorrido.idRecorrido.value = id;
			document.getElementById("formBorrarRecorrido").submit();
		}
	});
});

$('#route_table tbody').on('click', '#verRecorrido', function (e) {
	var data = route_table.row(this.closest("tr")).data();
	e.preventDefault();
	document.formVerRecorrido.idRecorrido.value = data["id"];
	document.getElementById("formVerRecorrido").submit();
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
	        	$('.form-horizontal').css('margin-bottom', '0');
	        	break;
	        default:
	            $(this).val('');
				document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
				$('.form-horizontal').css('margin-bottom', '8rem');
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
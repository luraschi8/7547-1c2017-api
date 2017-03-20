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

<title>Atracciones</title>

</head>
<body>

	<h1 class="page-header">
		Atracciones
	</h1>

<div class="panel-group">
	<div class="panel panel-primary">
		<div class="panel-body">
			<table id="tablita" class="display order-column" cellspacing="0"
				width="100%">
				<thead>
					<tr>
						<th>Nombre</th>
						<th>Ciudad</th>
						<th>Horario</th>
						<th>Precio</th>
						<th>Latitud</th>
						<th>Longitud</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
	</div>
</div>

	<form:form id="formModificar" action="atraccionesModificar" method="post" commandName="atraccion">
		<form:input id="id" path="id" type="hidden"/>
		<form:input id="nombre" path="nombre" type="hidden"/>
		<form:input id="horarioVisitaComienzo" path="horarioVisitaComienzo" type="hidden"/>
		<form:input id="horarioVisitaFin" path="horarioVisitaFin" type="hidden"/>
		<form:input id="precio" path="precio" type="hidden"/>
		<form:input id="latitud" path="latitud" type="hidden"/>
		<form:input id="longitud" path="longitud" type="hidden"/>
	</form:form>
	
	<c:set var="value">
		Desea borrar?
	</c:set>
	<input id="mensajeBorrar" type="hidden" value="${value}" />
	
	<c:set var="borrar">
		Borrar
	</c:set>

	<c:set var="modificar">
		Modificar
	</c:set>

<div class="wait"></div>

<script>

$(document).ready(function(){

	var table = $('#tablita').DataTable( {
		dom: 'Bfrtip',
		ajax: "atraccionesJson",
	    columns: [
	        {data: "nombre" },
	        {data: "nombre" },
	        {	data: "horarioVisitaComienzo",
	        	render: function (data,type,row) {
	        		return data + '-' + row.horarioVisitaFin;
	        	}
	        },
	        {data: "precio" },
	        {data: "latitud" },
	        {data: "longitud" },
	        {defaultContent:'<button class="btn btn-danger" id="borrar">${borrar}</button>'},
	        {defaultContent:'<button class="btn btn-warning" id="modificar">${modificar}</button>'}
	        ],
	    select:true,
	    paging:true,
	    pageLength:50,
	    ordering:true,
	    buttons: [
	              {
	                  text: '<button class="btn btn-success pull-left" id="nuevo">Nuevo</button>',
	                  action: function ( e, dt, node, config ) {
	                      window.location = "atracciones";
	                  }
	              }
	          ]
	});
	
	$(document).on({
	    ajaxStart: function() {$("body").addClass("loading");},
	    ajaxStop: function() {$("body").removeClass("loading");}
	});

	$('#tablita tbody').on('click', '#borrar', function (e) {
		var data = table.row(this.closest("tr")).data();
		var json = {
			"id" : data["id"],
			"nombre" : data["nombre"],
			"stockHuevos" : data["stockHuevos"],
			"stockMaximo" : data["stockMaximo"],
			"borrado" : data["borrado"]
		};
		var mensaje = document.getElementById("mensajeBorrar").value;
		e.preventDefault();
		bootbox.confirm(mensaje, function (response) {
			if (response) {
				$.ajax({
					url : "depositosBorrarJson",
					type : "DELETE",
					data : JSON.stringify(json),
					dataType : "json",
					contentType : "application/json",
					processData : false,
					complete : function () {
						table.ajax.reload();
					}
				});
			}
		});
	});
	
	
	$('#tablita tbody').on('click', '#modificar', function (e) {
		var data = table.row(this.closest("tr")).data();
		e.preventDefault();
		document.getElementById("id").value = data["id"];
		document.getElementById("nombre").value = data["nombre"];
		document.getElementById("stockHuevos").value = data["stockHuevos"];
		document.getElementById("stockMaximo").value = data["stockMaximo"];
		document.getElementById("borrado").value = data["borrado"];
		document.getElementById("formModificar").submit();
	});
});

</script>
</body>
</html>
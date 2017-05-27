<!-- Google Key AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<jsp:include page="../template/importacion.jsp"></jsp:include>
	
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Reportes - Usuarios únicos por país y red social</title>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<body>

	<nav class="navbar navbar-default">
	  	<div class="container-fluid">
		    <ul class="nav navbar-nav">
		      	<li><a href="ciudades">Ciudades</a></li>
		      	<li class="active"><a href="atraccionesDeMayorInteres">Reportes</a></li>
		    </ul>
	  	</div>
	</nav>
	
	<nav class="navbar navbar-default">
	  	<div class="container-fluid">
		    <ul class="nav navbar-nav">
		      	<li><a href="atraccionesDeMayorInteres">Atracciones de mayor interés</a></li>
		      	<li><a href="usuariosUnicosGlobales">Usuarios únicos globales</a></li>
		      	<li class="active"><a href="usuariosUnicosPorPaisYRedSocial">Usuarios únicos por país y red social</a></li>
		    </ul>
	  	</div>
	</nav>
	
	<h1 class="page-header report-new-page-header" style="width: 94%; margin-left: 3%; margin-right: 3%">Reportes - Usuarios únicos por país y red social</h1>

	<div style="display: inline-block;">
		<div style="float: left;">
			<div style="width: 900px; height: 500px;" id="chart_div"></div>
			<div style="width: 900px; height: 500px; display: none;" id="secondary_chart_div"></div>
			<div style="width: 900px; height: 500px; display: none;" id="no_results">
				<label style="margin-left: 5%; margin-top: 50px; font-size:25px">
				No se cuenta con datos para el rango de fechas seleccionado</label>
			</div>
		</div>
		
		<div style="float: right; margin-top: 55px; width: 200px; height: 50px;" id="select_date">
			<label>Filtrar por fecha</label>
			<p>Fecha inicio: <input type="text" id="date_from"></p>
			<p>Fecha fin: <input type="text" id="date_to"></p>
			<input id="botonBuscar" class="btn btn-default btn-primary" type="button" value="Buscar"/>
		</div>
	</div>
	
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
	
	google.charts.load('current', {'packages':['corechart']});

	$('#botonBuscar').on('click', function(e) {
		e.preventDefault();
		var formData = new FormData();
		formData.append("fechaInicio", document.getElementById("date_from").value);
		formData.append("fechaFin", document.getElementById("date_to").value);
		$.ajax({
			url : "cantidadUsuariosPais",
			type : "POST",
			data : formData,
			enctype: 'multipart/form-data',
			processData : false,
			contentType: false,
			dataType: 'json',
			success: function (data) {
				if (data) {
					var data_array = [
						['País', '']
					];
					
					$.each(data, function(k, v) {
					    data_array.push([k, parseInt(v)]);
					});
	
					if (data_array.length > 1) {
						document.getElementById("no_results").style.display = "none";
						document.getElementById("secondary_chart_div").style.display = "none";
						document.getElementById("chart_div").style.display = "block";
						google.charts.setOnLoadCallback(function() {
							drawCountriesChart(data_array);
						});
					} else {
						document.getElementById("chart_div").style.display = "none";
						document.getElementById("secondary_chart_div").style.display = "none";
						document.getElementById("no_results").style.display = "block";
					}
				}
			}
		});
	});

	function drawSelectedCountryChart(data_array) {
		var data = google.visualization.arrayToDataTable(data_array);
		
		var options = {
			title : 'Usuarios únicos por país y red social'
		};
		
		var chart = new google.visualization.PieChart(document.getElementById('secondary_chart_div'));
		chart.draw(data, options);
	}
	
	function drawCountriesChart(data_array) {
		var data = google.visualization.arrayToDataTable(data_array);
		
		var options = {
			title : 'Usuarios únicos por país y red social'
		};
		
		var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
		chart.draw(data, options);

		// The select handler. Call the chart's getSelection() method
		function selectHandler() {
			var selectedItem = chart.getSelection()[0];
			if (selectedItem) {
				var value = data.getValue(selectedItem.row, 0);

				var formData = new FormData();
				formData.append("fechaInicio", document.getElementById("date_from").value);
				formData.append("fechaFin", document.getElementById("date_to").value);
				formData.append("pais", value);
				$.ajax({
					url : "cantidadUsuariosRedSocialYSinLogin",
					type : "POST",
					data : formData,
					enctype: 'multipart/form-data',
					processData : false,
					contentType: false,
					dataType: 'json',
					success: function (data) {
						if (data) {
							var cantidades = data.data.split(",");
							var data_array = [
								['Tipo acceso', ''],
								["Facebook", parseInt(cantidades[0])],
								["Sin login", parseInt(cantidades[1])]
							];
							if (cantidades[0] == cantidades[1] == 0) {
								document.getElementById("no_results").style.display = "none";
								document.getElementById("chart_div").style.display = "block";
								document.getElementById("secondary_chart_div").style.display = "block";
								google.charts.setOnLoadCallback(function() {
									drawSelectedCountryChart(data_array);
								});
							} else {
								document.getElementById("chart_div").style.display = "none";
								document.getElementById("secondary_chart_div").style.display = "none";
								document.getElementById("no_results").style.display = "block";
							}
						}
					}
				});
			}
		}

		// Listen for the 'select' event, and call my function selectHandler() when
		// the user selects something on the chart.
		google.visualization.events.addListener(chart, 'select', selectHandler);
	}
	</script>
	
	<script src="${pageContext.request.contextPath}/js/ownFunctions.js"></script>
	
	<script>
		iniatilizeDates("#date_from", "#date_to");
	</script>
</body>
</html>
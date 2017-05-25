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
		<div style="float: left; width: 900px; height: 500px;" id="chart_div"></div>
		
		<div style="float: right; margin-top: 55px; width: 200px; height: 50px;" id="select_date">
			<label>Filtrar por fecha</label>
			<p>Fecha inicio: <input type="text" id="date_from"></p>
			<p>Fecha fin: <input type="text" id="date_to"></p>
		</div>
	</div>
	
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
	
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(function() {
		drawChart(data_array);
	});
	
	var data_array = [
		['País', ''],
		["Argentina", 165],
		["Uruguay", 135],
		["Brasil", 157]
	];
	
	function drawChart(data_array) {
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
				alert('Se eligió ' + value + ". Acá se debería dibujar el segundo Pie Chart para este país");
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
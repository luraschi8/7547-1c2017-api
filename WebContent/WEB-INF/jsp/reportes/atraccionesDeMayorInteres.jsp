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
	<title>Reportes - Atracciones de mayor interés</title>
	
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
	
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(function() {
		drawChart(data_array);
	});
	
	var data_array = [
		['Atraccion', ''],
		["Casa Rosada", 165],
		["Obelisco", 135],
		["MALBA", 157]
	];
	
	function drawChart(data_array) {
		var data = google.visualization.arrayToDataTable(data_array);
		
		var options = {
			title : 'Atracciones de mayor interés de los últimos doce meses',
			vAxis: {title: 'Cantidad usuarios'},
			hAxis: {title: 'Atracción'},
			seriesType: 'bars'
		};
		
		var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
		chart.draw(data, options);
		
	}
	</script>
</head>

<body>

	<nav class="navbar navbar-default">
	  	<div class="container-fluid">
		    <ul class="nav navbar-nav">
		      	<li><a href="ciudades">Ciudades</a></li>
		      	<li class="active"><a href="#">Reportes</a></li>
		    </ul>
	  	</div>
	</nav>
	
	<nav class="navbar navbar-default">
	  	<div class="container-fluid">
		    <ul class="nav navbar-nav">
		      	<li class="active"><a href="atraccionesDeMayorInteres">Atracciones de mayor interés</a></li>
		      	<li><a href="usuariosUnicosGlobales">Usuarios únicos globales</a></li>
		      	<li><a href="usuariosUnicosPorPaisYRedSocial">Usuarios únicos por país y red social</a></li>
		    </ul>
	  	</div>
	</nav>
	
	<h1 class="page-header report-new-page-header" style="width: 94%; margin-left: 3%; margin-right: 3%">Reportes - Atracciones de mayor interés</h1>

	<div id="chart_div" style="width: 900px; height: 500px;"></div>
</body>
</html>
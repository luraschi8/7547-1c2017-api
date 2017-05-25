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
	<title>Reportes - Usuarios únicos globales</title>
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
		      	<li class="active"><a href="usuariosUnicosGlobales">Usuarios únicos globales</a></li>
		      	<li><a href="usuariosUnicosPorPaisYRedSocial">Usuarios únicos por país y red social</a></li>
		    </ul>
	  	</div>
	</nav>
	
	<h1 class="page-header report-new-page-header" style="width: 94%; margin-left: 3%; margin-right: 3%">Reportes - Usuarios únicos globales</h1>

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
		['Mes', ''],
		[{"v": 1, "f":"01/2017"}, 165],
		[{"v": 2, "f":"02/2017"}, 135],
		[{"v": 3, "f":"03/2017"}, 157],
		[{"v": 4, "f":"04/2017"}, 139],
		[{"v": 5, "f":"05/2017"}, 136]
	];
	
	function drawChart(data_array) {
		var data = google.visualization.arrayToDataTable(data_array);
		
		var options = {
			title : 'Usuarios únicos globales',
			vAxis: {title: 'Cantidad usuarios'},
			hAxis: {title: 'Mes'},
			seriesType: 'bars',
			trendlines: {
			    0: {
			      	type: 'linear',
			      	color: 'red',
			      	lineWidth: 3,
			      	opacity: 1
				}
			}
		};
		
		var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
		chart.draw(data, options);
		
	}
	</script>
	
	<script src="${pageContext.request.contextPath}/js/ownFunctions.js"></script>
	
	<script>
		iniatilizeDates("#date_from", "#date_to");
	</script>
</body>
</html>
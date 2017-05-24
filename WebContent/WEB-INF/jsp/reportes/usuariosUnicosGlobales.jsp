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
		      	<li class="active"><a href="#">Reportes</a></li>
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
</body>
</html>
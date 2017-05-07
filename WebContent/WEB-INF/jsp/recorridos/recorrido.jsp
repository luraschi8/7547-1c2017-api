<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:include page="../template/importacion.jsp"></jsp:include>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trips - ${recorrido.nombre}</title>
</head>
<body>
	<div class="nav-wrapper">
		<div class="nav-menu">
   		    <ul class="clearfix">
	        	<li>Idioma
		        	<ul class="sub-menu">
			        	<li><a href="">Español</a></li>
			            <li><a href="">Inglés</a></li>
			        </ul>
			    </li>
	        </ul>
	    </div>
    </div>

	<h1 class="page-header" style="width: 94%; margin-left: 3%; margin-right: 3%">${recorrido.nombre} - ${recorrido.ciudad.nombre}</h1>	
	
</body>
</html>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
<jsp:include page="template/importacion.jsp"></jsp:include>
<link href="//fezvrasta.github.io/snackbarjs/dist/snackbar.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/signin.css" >
<script src="//cdnjs.cloudflare.com/ajax/libs/noUiSlider/6.2.0/jquery.nouislider.min.js"></script>
<title>Ingresar</title>
</head>

<body>

	<c:set var="Title" value="LogIn" scope="request" />
	<c:set var="Nombre" value="" scope="request" />

	<div class="container">
    
		<form:form action ="${pageContext.request.contextPath}/login" method="POST" class="form-signin">
			<div class="form-group label-floating">
		    	<label class="control-label" for="username">Usuario</label>
		 		<input class="form-control" id="username" name="username" type="text">
	  		</div>
	 		<div class="form-group label-floating">
		    	<label class="control-label" for="password">Contraseña</label>
		  		<input class="form-control" id="password" name ="password" type="password">
	  		</div>
			
			<button class="btn btn-lg btn-raised black-background white btn-block"  type="submit">Ingresar</button>
			
     	</form:form>
     	
     	<div id="errores" class="alert alert-warning fade in" style="display:none;"></div>
     	
     	<c:if test="${not empty error }">
     		<div id="errores" class="alert form-signin alert-warning fade in">
     			<center> Error</center>
     		</div>
     	</c:if>
    </div> 
</body>
</html>
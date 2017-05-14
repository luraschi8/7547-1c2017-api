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
	
	
	
	
	
	
	
	<div id="routeForm" style="width: 94%; margin-left: 3%; margin-right: 3%">
		<form:form id="formNuevo" name="formNuevo" action="recorridoNuevoValidar" method="post" commandName="recorrido" enctype="multipart/form-data">
		
		<div class="route_new_form" style="display: inline-block; overflow: hidden;">
			
			<div class="route_main_information_and_map" style="width: 100%; margin_bottom: 75%;">
				<!-- Bloque izquierdo -->
				<div class="route_left_block" style="float:left; margin-top: -1%">
	
					<!-- Información principal -->
					<div class="route_main_information">
						<input type="hidden" id="idCiudad" name="idCiudad" value="${recorrido.ciudad.id}"/>
						<input type="hidden" id="id" name="id" value="${recorrido.id}"/>
						<input type="hidden" name="atracciones" value=""/>
						
						
						
						
						
						


						
						
						
						
						
						<div class="route_name" style="margin-top: 1.5%">
							<form:label class="route_name_label" path="nombre">Nombre</form:label>
							<input type="hidden" id="nombreEditado" name="nombreEditado" value="${recorridoIdioma.recorrido.nombre}"/>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" id="edit-name" onclick="editField('#nombreEditado', 'ok-nombre', 'cancel-nombre', 'mensajeNombreVacio', true)">
								<span class="glyphicon glyphicon-pencil"></span>
							</button>
						</div>
						
						
						
						
						<div>
							<div>
								<p id="nombreEditado" style="white-space: pre-wrap;" class="atraction-box atraction-name-box" path="nombre" contenteditable="false" value="${recorrido.nombre}">${recorrido.nombre}</p>
								<textarea onkeydown="calculateMaxLength('#nombreEditadoTextarea', MAX_NOMBRE_RECORRIDO)" style="display:none" rows="1" id="nombreEditadoTextarea" class="route_box" value="${recorrido.nombre}">${recorrido.nombre}</textarea>
							</div>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: red;" id="cancel-nombre" onclick="cancelField('#nombreEditado', 'ok-nombre', 'cancel-nombre')">
								<span class="glyphicon glyphicon-remove"></span>
							</button>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: green;" id="ok-nombre" onclick="saveField('#nombreEditado', 'ok-nombre', 'cancel-nombre', 'mensajeNombreVacio', true)">
								<span class="glyphicon glyphicon-ok"></span>
							</button>
						</div>
						
						

						
						<div class="alert alert-danger fade in route_alert" id="mensajeNombreVacio" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado un nombre para el recorrido.
						</div>
						
						
						
						
						
						
						
						
						<div class="route_description" style="margin-top: 1%">
							<form:label class="route_description_label" path="descripcion">Descripción</form:label>
						</div>
						<div>
							<textarea onkeydown="calculateMaxLength('#descripcion', MAX_DESCRIPCION_RECORRIDO)" rows="4" id="descripcion" path="descripcion" name="descripcion" class="route_box"  placeholder="Ingrese la descripcion del recorrido" required></textarea>
						</div>
						
						<div class="alert alert-danger fade in route_alert" id="mensajeDescripcionVacia" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado una descripción para la atracción.
						</div>
					</div>
					
					<!-- Audioguía -->
					<div style="width: 100%; height: 15%">
						<div style="width: 100%; height: 40%">
							<label class="atraction-label" path="audioES">Audioguía</label>
						</div>
						<input type="hidden" id="audioCambiadoRecorrido" name="audioCambiadoRecorrido" value=0>
						<div style="width: 100%; height: 60%">
							<!-- Reproducir audioguía -->
							<div style="float: left; width: 85%; height: 50%">
								<audio id="audioRecorrido" style="width: 100%;" controls>
								    <source type="audio/mpeg">
								</audio> 
							</div>
							
							<!-- Botón agregar audioguía -->
							<div style="float: right; width: 15%; height: 50%; text-align: right;">
								<button type="button" class="btn btn-default btn-sm btn-atraction-get-route-audio-file" id="getAudioRecorrido">
									<span class="glyphicon glyphicon-pencil"></span>
								 </button>
							
								<button type="button" class="btn btn-default btn-sm btn-atraction-erase-route-audio-file" id="borrarAudioRecorrido">
									<span class="glyphicon glyphicon-erase"></span>
								 </button>
						
								<input type="file" name="archivoAudioguiaRecorrido" id="archivoAudioguiaRecorrido"/>
							</div>
						</div>
					</div>
					
					<div class="alert alert-danger fade in atraction-alert-incorrect-audio" id="mensajeAudioRecorridoIncorrectoError" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo seleccionado no es un audio válido. Por favor, introduzca otro.
					</div>
					
					<div class="alert alert-danger fade in atraction-alert-incorrect-audio" id="mensajeAudioRecorridoTamano" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo pesa mas de 3MB. Por favor, seleccione uno de menor tamaño.
					</div>
				</div>
				
				<!-- Bloque derecho -->
				<div class="route_right_block" style="float: right">
					<!-- Mapa -->
					<div id="route_map_group">
						<div id="view_or_edit_route_map" class="view_or_edit_route_map"></div>
						
						<div class="alert alert-danger fade in error_msg_new_route_no_atraction" id="mensajeNingunaAtraccionElegida" style="display: none">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado ninguna atracción para el recorrido. Debe poseer al menos una.
						</div>
					</div>
				</div>
			</div>
			
			<div class="route_tables" style="width: 100%;">
				<div class="route_left_block" style="clear: both; float: left; width: 48%; margin-top: 2%;">
					<label>Atracciones de la ciudad</label>
					<div style="width: 100%;" class="panel panel-primary route-panel">
						<div class="panel-body route_panel_body">
							<table id="table_all_atractions" class="display order-column route_board" cellspacing="0">
								<thead>
									<tr>
										<th></th> <!-- Imagen -->
										<th></th> <!-- Nombre -->
										<th></th> <!-- Agregar -->
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
				
				<div class="route_right_block" style="float: right; width: 48%; margin-top: 2%;">
					<label>Atracciones del recorrido</label>
					<div style="width: 100%;" class="panel panel-primary route-panel">
						<div class="panel-body route_panel_body">
							<table id="table_route_atractions" class="display order-column route_board" cellspacing="0">
								<thead>
									<tr>
										<th></th> <!-- Quitar -->
										<th></th> <!-- Orden -->
										<th></th> <!-- Imagen -->
										<!--<th></th>--> <!-- Nombre -->
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<div class="alert alert-danger fade in error_msg_route_already_exists" id="mensajeNombreRepetido" style="display: none;">
		 	<a class="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>&iexclError!</strong>El recorrido seleccionado ya se encuentra registrado. Seleccione otro nombre.
		</div>
		
		</form:form>
	</div>
	
	<form:form id="formAtras" action="ciudadVer?idCiudad=${recorrido.ciudad.id}" method="post"></form:form>
	<div class="btn-final" style="text-align:center;">
		<input id="botonAtras" class="btn btn-default" type="button" value="Atrás" />
		<input id="botonGuardar" class="btn btn-default btn-primary" type="button" value="Aceptar" />
	</div>

<script src="${pageContext.request.contextPath}/js/ownFunctions.js"></script>

<script>	
$('#botonAtras').on('click', function(e) {
	e.preventDefault();
	document.getElementById("formAtras").submit();
});
</script>
	
</body>
</html>
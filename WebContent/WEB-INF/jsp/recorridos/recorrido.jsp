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
	
	
	
	
	
	
	
	<div id="attractionForm">
	<form:form id ="formModificar" name="formModificar" action="atraccionModificar" method="post" commandName="atraccion" enctype="multipart/form-data">
		<form:input type="hidden" id="id" name="id" path="id" value="${atraccion.id}"/>

		<div class="atraction-new-form" style="width: 100%; overflow: hidden;"> 
			
			<!-- Bloque izquierdo (Información principal, Plano, Galería y Audioguia) -->	
			<div style="float:left; margin-top:-0.8rem">
				
				<!-- Información principal -->
				<div class="atraction-main-information">
					<input type="hidden" id="idCiudad" name="idCiudad" value="${atraccion.atraccion.ciudad.id}"/>
					<input type="hidden" id="latitudCiudad" name="latitudCiudad" value="${atraccion.atraccion.ciudad.latitud}"/>
					<input type="hidden" id="latitudCiudad" name="latitudCiudad" value="${atraccion.atraccion.ciudad.longitud}"/>
	
					<input type="hidden" id="latitud" name="latitud" value="${atraccion.atraccion.latitud}"/>
					<input type="hidden" id="longitud" name="longitud" value="${atraccion.atraccion.longitud}"/>
					
					<div>
						<form:label class="atraction-label atraction-main-information-label" path="atraccion.nombre">Nombre</form:label>
						<input type="hidden" id="nombre" name="nombre" value="${atraccion.atraccion.nombre}"/>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" id="edit-name" onclick="editField('#nombreEditado', 'ok-nombre', 'cancel-nombre', 'mensajeNombreVacio', true)">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
					</div>
					<div>
						<div>
							<p id="nombreEditado" style="white-space: pre-wrap;" class="atraction-box atraction-name-box" path="nombre" contenteditable="false" value="${atraccion.atraccion.nombre}">${atraccion.atraccion.nombre}</p>
							<textarea onkeydown="calculateMaxLength('#nombreEditadoTextarea', MAX_NOMBRE_ATRACCION)" style="display:none" rows="1" id="nombreEditadoTextarea" class="atraction-box atraction-name-box" value="${atraccion.atraccion.nombre}">${atraccion.atraccion.nombre}</textarea>
						</div>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: red;" id="cancel-nombre" onclick="cancelField('#nombreEditado', 'ok-nombre', 'cancel-nombre')">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: green;" id="ok-nombre" onclick="saveField('#nombreEditado', 'ok-nombre', 'cancel-nombre', 'mensajeNombreVacio', true)">
							<span class="glyphicon glyphicon-ok"></span>
						</button>
					</div>
					
					<div class="alert alert-danger fade in atraction-alert" id="mensajeNombreVacio" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> El nombre no puede estar vacío. Se ha dejado el último nombre válido.
					</div>
					
					<div>
						<form:label class="atraction-label atraction-description-label" path="descripcion">Descripción</form:label>
						<input type="hidden" id="descripcion" name="descripcion" value="${atraccion.descripcion}"/>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" id="edit-description" onclick="editField('#descripcionEditada', 'ok-descripcion', 'cancel-descripcion', 'mensajeDescripcionVacia', true)">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
					</div>
					<div>
						<div>
						    <p id="descripcionEditada" style="white-space: pre-wrap;" class="atraction-box atraction-name-box" path="descripcion" contenteditable="false" value="${atraccion.descripcion}">${atraccion.descripcion}</p>
							<textarea onkeydown="calculateMaxLength('#descripcionEditadaTextarea', MAX_DESCRIPCION_ATRACCION)" style="display:none" rows="4" id="descripcionEditadaTextarea" class="atraction-box atraction-name-box" value="${atraccion.descripcion}">${atraccion.descripcion}</textarea>
						</div>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: red;" id="cancel-descripcion" onclick="cancelField('#descripcionEditada', 'ok-descripcion', 'cancel-descripcion')">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: green;" id="ok-descripcion" onclick="saveField('#descripcionEditada', 'ok-descripcion', 'cancel-descripcion', 'mensajeDescripcionVacia', true)">
							<span class="glyphicon glyphicon-ok"></span>
						</button>
					</div>
					
					<div class="alert alert-danger fade in atraction-alert" id="mensajeDescripcionVacia" style="display: none; width:54rem">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> La descripción no puede estar vacía. Se ha dejado la última descripción válida.
					</div>
					
					<div>
						<form:label class="atraction-label atraction-schedule-label" path="horario">Horario</form:label>
						<input type="hidden" id="horario" name="horario" value="${atraccion.horario}"/>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" id="edit-horario" onclick="editField('#horarioEditado', 'ok-horario', 'cancel-horario', null, false)">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
					</div>
					<div>
						<div>
							<p id="horarioEditado" style="white-space: pre-wrap;" class="atraction-box atraction-name-box" path="horario" contenteditable="false" value="${atraccion.horario}">${atraccion.horario}</p>
							<textarea onkeydown="calculateMaxLength('#horarioEditadoTextarea', MAX_HORARIO_ATRACCION)" style="display:none" rows="3" id="horarioEditadoTextarea" class="atraction-box atraction-name-box" value="${atraccion.horario}">${atraccion.horario}</textarea>
						</div>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: red;" id="cancel-horario" onclick="cancelField('#horarioEditado', 'ok-horario', 'cancel-horario')">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: green;" id="ok-horario" onclick="saveField('#horarioEditado', 'ok-horario', 'cancel-horario', null, false)">
							<span class="glyphicon glyphicon-ok"></span>
						</button>
					</div>
					
					<div>
						<form:label class="atraction-label atraction-cost-label" path="precio">Precio</form:label>
						<input type="hidden" id="precio" name="precio" value="${atraccion.precio}"/>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" id="edit-precio" onclick="editField('#precioEditado', 'ok-precio', 'cancel-precio', null, false)">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
					</div>
					<div>
						<div>
							<p id="precioEditado" style="white-space: pre-wrap;" class="atraction-box atraction-name-box" path="precio" contenteditable="false" value="${atraccion.precio}">${atraccion.precio}</p>
							<textarea onkeydown="calculateMaxLength('#precioEditadoTextarea', MAX_PRECIO_ATRACCION)" style="display:none" rows="3" id="precioEditadoTextarea" class="atraction-box atraction-name-box" value="${atraccion.precio}">${atraccion.precio}</textarea>
						</div>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: red;" id="cancel-precio" onclick="cancelField('#precioEditado', 'ok-precio', 'cancel-precio')">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: green;" id="ok-precio" onclick="saveField('#precioEditado', 'ok-precio', 'cancel-precio', null, false)">
							<span class="glyphicon glyphicon-ok"></span>
						</button>
					</div>
					
					<div>
						<form:label id="recorrible" name="recorrible" class="atraction-label atraction-recorrible-label" path="atraccion.recorrible">&iquestEs recorrible?</form:label>
						  	<div>
							  	<input type="radio" id="es-recorrible" name="recorrible" path="recorrible" value="1" style="margin: 4px" onclick="$('#blueprints').show(); $('#view-atraction-points-of-interest-panel').show();">Sí
							  	<input type="radio" id="no-es-recorrible" name="recorrible" path="recorrible" value="0" style="margin: 4px; margin-left: 15px;" onclick="$('#blueprints').hide(); $('#view-atraction-points-of-interest-panel').hide();">No
							</div>
						</form>
					</div>
				</div>
			</div>
						
			<!-- Bloque derecho (Mapa, Puntos de interés y Reseñas) -->
			<div class="atraction-right-block" style="float:right; margin-top: -1rem;">
				<!-- Mapa -->
				<div class="view-atraction-map-group">
					<label>Ubicación</label>
					<div class="atraction-map-div">
						<input id="atraction-map-input" class="atraction-map-controls" type="text" placeholder="Ingresar ubicación">
						<div id="atraction-map"></div>
					</div>
					
					<div class="atraction-map-editing-buttons">
						<div>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" id="edit-coordinates" onclick="editCoordinates()">
								<span class="glyphicon glyphicon-pencil"></span>
							</button>
						</div>
						
						<div>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: red;" id="cancel-coordinates" onclick="cancelEditingCoordinates()">
								<span class="glyphicon glyphicon-remove"></span>
							</button>
							<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: green;" id="ok-coordinates" onclick="saveCoordinates()">
								<span class="glyphicon glyphicon-ok"></span>
							</button>
						</div>
					</div>	
				</div>
				
				<div style="clear: left; margin-bottom: 36rem;">
					<div class="alert alert-danger fade in atraction-alert-no-location" id="mensajeUbicacionVacia" style="display: none">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> No se ha seleccionado una ubicación para la atracción.
					</div>
					
					<div class="alert alert-warning fade in atraction-alert-far-location" id="mensajeUbicacionLejana" style="display: none">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclAdvertencia!</strong> La atracción seleccionada está a más de 15km de la ciudad actual.
					</div>
				</div>
				
				<div id="view-atraction-points-of-interest-panel" class="panel panel-primary view-atraction-panel view-atraction-points-of-interest-panel">
					<div style="text-align:center">
						<input id="botonPuntosDeInteres" class="btn btn-ver-puntos-y-obras btn-puntos-de-interes" type="button" value="Puntos de interés y obras"/>
						<input id="botonAgregarPuntoDeInteres" class="btn btn-agregar-puntos-y-obras btn-nuevo-punto-de-interes" type="button" value="+" onclick="openNewPointOfInterestForm(); showCreationElements();"/>
					</div>
					
					<div class="panel-body atraction-points-of-interest">
						<table id="tablita" class="display order-column view-atraction-board" cellspacing="0" width="100%">
							<thead>
								<tr>
									<th></th>
									<th></th> <!-- Imagen -->
									<th></th> <!-- Nombre -->
									<th></th> <!-- Borrar -->
									<th></th> <!-- Ver -->
								</tr>
							</thead>
							<tbody id="sortable"></tbody>
						</table>
					</div>
				</div>
				
				<div class="alert alert-danger fade in atraction-alert-point-of-interest-needed" id="mensajePuntoDeInteresNecesario" style="display: none;">
				 	<a class="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>&iexclError!</strong> La atracción es recorrible. Debe por lo menos un punto de interés.
				</div>
				
				<!-- Tabla reseñas (comentarios) -->
				<div class="panel panel-primary view-atraction-panel view-atraction-comments-panel">
					<div style="text-align:center; font-size:110%">
						<p>Reseñas</p>
					</div>
					
					<div class="panel-body atraction-comments">
						<table id="tablaResenias" class="display order-column view-atraction-board" cellspacing="0" width="100%">
							<thead>
								<tr>
						            <th></th> <!-- Reseña -->
									<th></th> <!-- Borrar -->
									<th></th> <!-- Editar -->
						        </tr>	
							</thead>
							<tbody>
				            </tbody>
						</table>
					</div>
				</div>				
			</div>
		</div>
			
		<div class="alert alert-danger fade in atraction-alert-already-exists" id="mensajeNombreRepetido" style="display: none;">
		 	<a class="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>&iexclError!</strong> La atracción seleccionada ya se encuentra registrada. Seleccione otra.
		</div>
	</form:form>
</div>
	
	
	
</body>
</html>
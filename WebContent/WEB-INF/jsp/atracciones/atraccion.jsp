<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>

<head>
<jsp:include page="../template/importacion.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trips - ${atraccion.nombre}</title>
</head>

<body>

	<h1 class="page-header atraction-new-page-header" style="margin-left:5rem">${atraccion.nombre} - ${atraccion.ciudad.nombre}</h1>

<div id="atraction-form">
	<form:form id ="formModificar" name="formModificar" action="atraccionModificar" method="post" commandName="atraccion" enctype="multipart/form-data">
		<form:input type="hidden" id="id" name="id" path="id" value="${atraccion.id}"/>
		
		<div class="atraction-new-form" style="width: 100%; overflow: hidden;"> 
			
			<!-- Bloque izquierdo (Información principal, Plano, Galería y Audioguia) -->	
			<div style="float:left; margin-top:-0.8rem">
				
				<!-- Información principal -->
				<div class="atraction-main-information">
					<input type="hidden" id="idCiudad" name="idCiudad" value="${atraccion.ciudad.id}"/>
					<input type="hidden" id="latitudCiudad" name="latitudCiudad" value="${atraccion.ciudad.latitud}"/>
					<input type="hidden" id="latitudCiudad" name="latitudCiudad" value="${atraccion.ciudad.longitud}"/>
	
					<form:input type="hidden" id="latitud" name="latitud" path="latitud"/>
					<form:input type="hidden" id="longitud" name="longitud" path="longitud"/>
					
					<div>
						<form:label class="atraction-label atraction-main-information-label" path="nombre">Nombre</form:label>
						<input type="hidden" id="nombre" name="nombre" value="${atraccion.nombre}"/>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" id="edit-name" onclick="editField('#nombreEditado', 'ok-nombre', 'cancel-nombre', 'mensajeNombreVacio', true)">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
					</div>
					<div>
						<div>
							<p id="nombreEditado" style="white-space: pre-wrap;" class="atraction-box atraction-name-box" path="nombre" contenteditable="false" value="${atraccion.nombre}">${atraccion.nombre}</p>
							<textarea onkeydown="calculateMaxLength('#nombreEditadoTextarea', MAX_NOMBRE_ATRACCION)" style="display:none" rows="1" id="nombreEditadoTextarea" class="atraction-box atraction-name-box" value="${atraccion.nombre}">${atraccion.nombre}</textarea>
						</div>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: red;" id="cancel-nombre" onclick="cancelField('#nombreEditado', 'ok-nombre', 'cancel-nombre')">
							<span class="glyphicon glyphicon-remove"></span>
						</button>
						<button type="button" class="btn btn-default btn-sm btn-edit-main-information" style="display:none; background-color: green;" id="ok-nombre" onclick="saveField('#nombreEditado', 'ok-nombre', 'cancel-nombre', 'mensajeNombreVacio', true)">
							<span class="glyphicon glyphicon-ok"></span>
						</button>
					</div>
					
					<div class="alert alert-warning fade in atraction-alert" id="mensajeNombreVacio" style="display: none;">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
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
					
					<div class="alert alert-warning fade in atraction-alert" id="mensajeDescripcionVacia" style="display: none; width:54rem">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
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
						<form:label id="recorrible" name="recorrible" class="atraction-label atraction-recorrible-label" path="recorrible">&iquestEs recorrible?</form:label>
						  	<div>
							  	<input type="radio" id="es-recorrible" name="recorrible" path="recorrible" value="1" style="margin: 4px" onclick="$('#blueprints').show();">Sí
							  	<input type="radio" id="no-es-recorrible" name="recorrible" path="recorrible" value="0" style="margin: 4px; margin-left: 15px;" onclick="$('#blueprints').hide();">No
							</div>
						</form>
					</div>
				</div>
			
				<!-- Plano -->
				<div id="blueprints">
					<div>
						<form:label class="atraction-label atraction-blueprints-label" path="plano">Plano</form:label>
					</div>
					<div class="atraction-blueprints-box" style="float:left">
						<img id="plano" style="width:100%; height:100%">
						<button type="button" class="btn btn-default btn-sm atraction-get-blueprints" id="atraction-get-blueprints">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
						<input id="planoCambiado" name="planoCambiado" type="hidden" value="0">
						<input type="file" name="archivoPlano" id="archivoPlano"/>
					</div>
	
					<div class="alert-message">
						<div class="alert alert-warning fade in atraction-alert" id="mensajePlanoNecesario" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> La atracción es recorrible. Debe proporcionarse un plano.
						</div>
						<div class="alert alert-warning fade in atraction-alert" id="mensajeImagenIncorrectaError" style="display: none;">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otro.
						</div>
					</div>
				</div>
				
				<!-- Galería -->
				<div>
					<input type="hidden" id="imagenesCambiadas" name="imagenesCambiadas">
					<input type="hidden" id="videoCambiado" name="videoCambiado" value=0>					
					
					<div>
						<form:label class="atraction-label atraction-gallery-label" path="listaImagenes">Galería</form:label>
					</div>
					<div id ="container" class="atraction-gallery-box" style="float:left">
						<img class="atraction-gallery" id="imagenGaleria" style="width:100%; height:100%;">
						<video id="videoGaleria" style="width:100%; height:100%;display:none" controls>
						</video>
						<button type="button" class="w3-button w3-display-left atraction-gallery-slide-left" onclick="nextGalleryItem(-1)">&#10094;</button>
						<button type="button" class="w3-button w3-display-right atraction-gallery-slide-right" onclick="nextGalleryItem(+1)">&#10095;</button>
					
						<input type="button" id="atraction-get-gallery-file" class="btn btn-default btn-atraction-get-gallery-file" value="+">
						
						<button type="button" class="btn btn-default btn-sm atraction-erase-multimedia" id="eliminarImagen">
							<span class="glyphicon glyphicon-erase"></span>
						 </button>
					</div>
					
					<div class="alert alert-warning fade in atraction-alert atraction-gallery-alert" id="mensajeHayVideo" style="display: none;">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> Ya se ha seleccionado un video anteriormente. Sólo se puede seleccionar uno.
					</div>
					
					<div class="alert alert-warning fade in atraction-alert atraction-gallery-alert" id="mensajeCincoArchivos" style="display: none;">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> Ya se han seleccionado 5 archivos, no se pueden agregar más.
					</div>
					
					<div class="alert alert-warning fade in atraction-alert atraction-gallery-alert" id="mensajeTamanoImagen" style="display: none;">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> La imagen no puede pesar más de 50KB.
					</div>
					
					<div class="alert alert-warning fade in atraction-alert atraction-gallery-alert" id="mensajeTamanoVideo" style="display: none;">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> El video no puede pesar más de 10MB.
					</div>
					
					<div class="alert alert-warning fade in atraction-alert atraction-gallery-alert" id="mensajeUnaImagen" style="display: none;">
					 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> Tiene que estar presente una imagen por lo menos!
					</div>
				</div>
				
				<!-- Audioguía -->
				<form:label class="atraction-label atraction-audio-label" path="audioES">Audioguía</form:label>
				<div>
					<!-- Reproducir audioguía -->
					<div style="float:left">
						<audio id="audio" controls>
						    <source type="audio/mpeg">
						</audio> 
					</div>
					
					<!-- Botón agregar audioguía -->
					<div style="text-align:center; float:right;">
						<input type="button" id="atraction-get-audio-file" class="btn btn-default btn-atraction-get-audio-file" value="Editar audioguía">
						<input type="file" name="archivoAudioguia" id="archivoAudioguia"/>
					</div>
				</div>
				
				<div class="alert alert-warning fade in atraction-alert-incorrect-audio" id="mensajeAudioIncorrectoError" style="display: none;">
				 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>Error!</strong> El archivo seleccionado no es un audio válido. Por favor, introduzca otro.
				</div>			
			</div>
						
			<!-- Bloque derecho (Mapa, Puntos de interés y Reseñas) -->
			<div class="atraction-right-block" style="float:right">
				<!-- Mapa -->
				<div class="view-atraction-map-group">
					<div style="float:left">
						<input id="atraction-map-input" class="atraction-map-controls" type="text" placeholder="Ingresar ubicación">
						<div id="atraction-map"></div>
					</div>
					
					<div class="atraction-map-editing-buttons" style="float:left">
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
				
				<div>
					<div class="alert alert-warning fade in atraction-alert-no-location" id="mensajeUbicacionVacia" style="display: none">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> No se ha seleccionado una ubicación para la atracción.
						</div>
						
						<div class="alert alert-warning fade in atraction-alert-far-location" id="mensajeUbicacionLejana" style="display: none">
						 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclAdvertencia!</strong> La atracción seleccionada está a más de 15km de la ciudad actual.
						</div>
				</div>
				
				<div class="panel panel-primary view-atraction-panel view-atraction-points-of-interest-panel">
					<div style="text-align:center">
						<input id="botonPuntosDeInteres" class="btn btn-ver-puntos-y-obras btn-puntos-de-interes" type="button" value="Puntos de interés y obras" />
						<input id="botonAgregarPuntoDeInteres" class="btn btn-agregar-puntos-y-obras btn-nuevo-punto-de-interes" type="button" value="+" onclick="openNewPointOfInterestForm()"/>
					</div>
					
					<div class="panel-body atraction-points-of-interest">
						<table id="tablita" class="display order-column view-atraction-board" cellspacing="0" width="100%">
							<thead>
								<tr>
									<th></th> <!-- Imagen -->
									<th></th> <!-- Nombre -->
									<th></th> <!-- Borrar -->
									<th></th> <!-- Ver -->
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
				</div>
				
				<!-- Tabla reseñas (comentarios) -->
				<div class="panel panel-primary view-atraction-panel view-atraction-comments-panel">
					<div style="text-align:center; font-size:110%">
						<p>Reseñas</p>
					</div>
					
					<div class="panel-body atraction-comments">
						<table id="tablita" class="display order-column view-atraction-board" cellspacing="0" width="100%">
							<thead>
								<tr>
									<th></th> <!-- Usuario -->
									<th></th> <!-- Comentario -->
									<th></th> <!-- Borrar -->
									<th></th> <!-- Editar -->
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
				</div>				
			</div>
		</div>
			
		<div class="alert alert-warning fade in atraction-alert-already-exists" id="mensajeNombreRepetido" style="display: none;">
		 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>&iexclError!</strong> La atracción seleccionada ya se encuentra registrada. Seleccione otra.
		</div>
	</form:form>
</div>

	
<div id="atraction-point-of-interest-popup-form">
	<form:form class="atraction-new-point-of-interest" id ="formNuevoPuntoDeInteres" name="formNuevoPuntoDeInteres" action="nuevoPuntoDeInteres" method="post" commandName="puntoDeInteres" enctype="multipart/form-data">
		<h2>Nuevo punto de interés</h2>
		
		<div>
			<div>
				<label class="atraction-label" path="nombre">Nombre</label>
			</div>
			<div>
				<input maxlength="50" id="pdi-nombre" path="nombre" name="pdi-nombre" class="atraction-box"  placeholder="Ingrese el nombre del punto de interés" required="required"></textarea>
			</div>
			
			<div class="alert alert-warning fade in atraction-alert" id="mensajeNombreVacioPuntoDeInteresError" style="display: none;">
			 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> El nombre no puede estar vacío.
			</div>
		</div>
		
		<div>
			<div>
				<label class="atraction-label" path="descripcion">Descripción</label>
			</div>
			<div>
				<textarea onkeydown="calculateMaxLength('#pdi-descripcion', MAX_DESCRIPCION_PUNTO_DE_INTERES)" id="pdi-descripcion" path="descripcion" name="pdi-descripcion" class="atraction-box"  placeholder="Ingrese la descripción del punto de interés" required="required"></textarea>
			</div>
			
			<div class="alert alert-warning fade in atraction-alert" id="mensajeDescripcionVaciaPuntoDeInteresError" style="display: none;">
			 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> La descripción no puede estar vacía.
			</div>
		</div>
		
		<div>
			<div>
				<label class="atraction-label" path="orden">Orden</label>
			</div>
			<div>
				<input maxlength="20" id="pdi-orden" path="orden" name="pdi-orden" class="atraction-box"  placeholder="Ingrese el orden del punto de interés" required="required"></textarea>
				<!--<select class="order-list" id="pdi-orden" path="orden" name="pdi-orden"></select>-->
			</div>
			
			<div class="alert alert-warning fade in atraction-alert" id="mensajeOrdenVacioPuntoDeInteresError" style="display: none;">
			 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> El orden no puede estar vacío.
			</div>
		</div>
		
		<div>
			<label class="atraction-label" path="imagen">Imagen</label>
		</div>
		<div class="atraction-point-of-interest-image-box">
			<img id="pdi-imagen" style="width:100%; height:100%">
			<button type="button" class="btn btn-default btn-sm atraction-poi-get-image" id="atraction-poi-get-image">
				<span class="glyphicon glyphicon-pencil"></span>
			</button>
			<input id="pdi-imagen-cambiada" name="pdi-imagen-cambiada" type="hidden" value="0">
			<input type="file" name="pdi-archivo-imagen" id="pdi-archivo-imagen" style="display: none"/>
		</div>
		
		<div class="alert alert-warning fade in atraction-alert" id="mensajeImagenIncorrectaPuntoDeInteresError" style="display: none;">
		 	<aclass="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>&iexclError!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otro.
		</div>
	</form:form>
		
	<div class="btn-final-pdi-form" style="text-align:center;">
		<input id="botonAtrasPuntoDeInteres" class="btn btn-default" type="button" value="Cancelar" onclick="closeNewPointOfInterestForm();"/>
		<input id="botonNuevoPuntoDeInteres" class="btn btn-default btn-primary" type="button" value="Guardar"/>
	</div>
</div>

<div id="atraction-comment-popup">
	<div class="atraction-view-comment" id ="atraction-view-comment" name="atraction-view-comment">
		<h2>Edición reseña</h2>
		
		<div class="atraction-comment-group">
			<div style="float: left; margin-top: 4.5rem;">
				<!-- <img src="${pageContext.request.contextPath}/imagenAtraccion?id=1" style="width:7.5rem; height:7.5rem"><!-- TODO Acá iría el path a la imagen del usuario ${comentario.usuario.imagen}-->
				<p id="comentario-nombre-usuario">Pepe<!-- TODO Acá iría el nombre del usuario ${comentario.usuario.nombre} --></p>
			</div>
			
			<div style="float: right;">
			 	<div>
					<label class="atraction-label">Enviado el día... </label><!-- TODO Acá habría que agregar la fecha y la hora del comentario ${comentario.fecha} ${comentario.hora} --></p>
					<textarea onkeydown="calculateMaxLength('#atraction-comment', MAX_COMENTARIO)" id="atraction-comment" path="comentario" name="atraction-comment" class="atraction-box" required="required" rows="5"></textarea>
				</div>
			</div>
		</div>
	</div>
	
	<form:form id="formGuardarEdicionComentario" action="atraccionVer?idAtraccion=${atraccion.id}" method="post"></form:form>
	<div class="btn-final-edicion-comentario-popup" style="text-align:center; clear: right;">
		<input id="botonCancelarComentario" class="btn btn-default" type="button" value="Cancelar" onclick="closeViewCommentPopUp();"/>
		<input id="botonAceptarComentario" class="btn btn-default btn-primary" type="button" value="Guardar"/>
	</div>
</div>

<form:form id="formAtras" action="ciudadVer?idCiudad=${atraccion.ciudad.id}" method="post"></form:form>
<div class="btn-final" style="text-align:center;">
	<input id="botonAtras" class="btn btn-default" type="button" value="Atrás" />
	<input id="botonNuevo" class="btn btn-default btn-primary" type="button" value="Aceptar" />
</div>


<script>
function disableAtractionPage() {
	$("#atraction-form").addClass("disable-buttons");
	$(".btn-final").addClass("disable-buttons");
	$(".atraction-new-page-header").addClass("disable-buttons");
}

function openNewPointOfInterestForm() {
	hideAllAtractionErrorMessages();
	document.getElementById('atraction-point-of-interest-popup-form').style.display = 'block';
	document.getElementById('atraction-point-of-interest-popup-form').focus();
	document.getElementById('atraction-form').blur();
	disableAtractionPage();
}

function openViewCommentPopUp() {
	hideAllAtractionErrorMessages();
	document.getElementById('atraction-comment-popup').style.display = 'block';
	document.getElementById('atraction-comment-popup').focus();
	document.getElementById('atraction-form').blur();
	disableAtractionPage();
}

function enableAtractionPage() {
	$("#atraction-form").removeClass("disable-buttons");
	$(".btn-final").removeClass("disable-buttons");
	$(".atraction-new-page-header").removeClass("disable-buttons");
}

function closeNewPointOfInterestForm() {
	document.getElementById('atraction-point-of-interest-popup-form').style.display = 'none';
	document.getElementById('pdi-nombre').value = '';
	document.getElementById('pdi-descripcion').value = '';
	document.getElementById('pdi-orden').value = '';
	document.getElementById('pdi-imagen').src = '//:0';
	enableAtractionPage();
}

function closeViewCommentPopUp() {
	document.getElementById('atraction-comment-popup').style.display = 'none';
	enableAtractionPage();
}

$(document).ready(function() {
	validateImage("atraction-poi-get-image", "pdi-archivo-imagen", "pdi-imagen", "mensajeImagenIncorrectaPuntoDeInteresError");
});
</script>


<!-- Definición de constantes -->
<script>
const MAX_NOMBRE_ATRACCION = "50";
const MAX_DESCRIPCION_ATRACCION = "250";
const MAX_HORARIO_ATRACCION = "100";
const MAX_PRECIO_ATRACCION = "100";
$("#nombreEditadoTextarea").attr("maxlength", MAX_NOMBRE_ATRACCION);
$("#descripcionEditadaTextarea").attr("maxlength", MAX_DESCRIPCION_ATRACCION);
$("#horarioEditadoTextarea").attr("maxlength", MAX_HORARIO_ATRACCION);
$("#precioEditadoTextarea").attr("maxlength", MAX_PRECIO_ATRACCION);

const MAX_DESCRIPCION_PUNTO_DE_INTERES = "250";
$("#pid-descripcion").attr("maxlength", MAX_DESCRIPCION_PUNTO_DE_INTERES);

const MAX_COMENTARIO = "500";
$("atraction-comment").attr("maxlength", MAX_DESCRIPCION_PUNTO_DE_INTERES);

if (${atraccion.recorrible}) {
	$("#es-recorrible").attr("checked", "checked");
	$("#blueprints").show();
} else {
	$("#no-es-recorrible").attr("checked", "checked");
	$("#blueprints").hide();
}
</script>

<script>
var far_away = false;

function updateForm() {
	document.formModificar.nombre.value = $('#nombreEditado').html();
	document.formModificar.descripcion.value = $('#descripcionEditada').html();
	document.formModificar.horario.value = $('#horarioEditado').html();
	document.formModificar.precio.value = $('#precioEditado').html();
	document.formModificar.recorrible.value = $("input[name='recorrible']:checked").val();
}

$('#botonAtras').on('click', function(e) {
	e.preventDefault();
	document.getElementById("formAtras").submit();
});

$('#botonNuevo').on('click', function(e) {
	e.preventDefault();
	document.getElementById("mensajeNombreRepetido").style.display = 'none';
	document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	document.getElementById("mensajeAudioIncorrectoError").style.display = 'none';
	updateForm();
	updateCoordinatesForm();
	validarAtraccionRepetida();
});

function validarElemento(elemento, mensaje, hayError) {
	if ((document.getElementById(elemento).value == '') && (!hayError)) {
		document.getElementById(mensaje).style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById(mensaje).style.display = 'none';
	}
	return hayError;
}

function validarPlano(plano, mensaje, hayError) {
	if ((document.getElementById(plano).src == "http://:0/") && (!hayError)) {
		document.getElementById(mensaje).style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById(mensaje).style.display = 'none';
	}
	return hayError;
}

function validarAtraccionRepetida() {
	hideAllAtractionErrorMessages();
	hayError = 0;
	hayError = validarElemento('nombre', 'mensajeNombreVacio', hayError);
	hayError = validarElemento('descripcion', 'mensajeDescripcionVacia', hayError);
	
	if (document.getElementById('es-recorrible').checked) {
		hayError = validarPlano('plano', 'mensajePlanoNecesario', hayError);
	} else {
		document.getElementById("mensajePlanoNecesario").style.display = 'none';
	}
	if ((imageNumber == 0) && (!hayError)) {
		document.getElementById("mensajeUnaImagen").style.display = 'block';
		hayError = 1;
	}
	if (hayError == 1) {
		return;
	}

	var ciudad = {
		"id": document.formModificar.idCiudad.value,
	}
	var json = {
		"ciudad": ciudad,
		"id": document.formModificar.id.value,
		"nombre": document.formModificar.nombre.value
	};
	$.ajax({
		url : "validarAtraccion",
		type : "POST",
		data : JSON.stringify(json),
		processData : false,
		dataType: "json",
		contentType : "application/json",
		success: function (data) {
			if (data.existe == false) {
				document.formModificar.recorrible.value = $("input[name='recorrible']:checked").val();
				if (document.formModificar.recorrible.value == 0) {
					document.getElementById("archivoPlano").src = "//:0";
					document.getElementById("plano").src = "//:0";
					document.getElementById("planoCambiado").value = "1";
				}
				if (far_away) {
				    bootbox.confirm({
			    	    message: "La atracción se encuentra a más de 15km de distancia de la ciudad. ¿Desea guardar los cambios de todos modos?",
			    	    buttons: {
			    	        confirm: {
			    	            label: 'Sí'
			    	        },
			    	        cancel: {
			    	            label: 'No'
			    	        }
			    	    },
			    	    callback: function(result) {
					        if (result) {
					        	document.getElementById("formModificar").submit();
					        }
			    	    }
				    });
			  	} else {
			  		document.getElementById("formModificar").submit();
				}
			} else {
				document.getElementById("mensajeNombreRepetido").style.display = 'block';
			}
		}
	});
}
</script>


<!-- Plano -->
<script>
$(document).ready(function() {
	document.getElementById('atraction-get-blueprints').onclick = function() {
		hideAllAtractionErrorMessages();
		document.getElementById('archivoPlano').addEventListener('change', readURL, true);
		document.getElementById('archivoPlano').src = "//:0";
		var fileButton = document.getElementById('archivoPlano');
		fileButton.click();
	};

	if (document.getElementById('es-recorrible').checked) {
		document.getElementById('plano').src = "${pageContext.request.contextPath}/planoAtraccion?id=${atraccion.id}";
	} else {
		document.getElementById('plano').src = "//:0";
		document.getElementById('archivoPlano').src = "//:0";
	}
	
	$("#archivoPlano").change(function() {
	    var val = $(this).val();
	    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
	        case 'gif': case 'jpg': case 'png': case 'jpeg': case 'bmp': 
	        	document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	        	break;
	        default:
	            $(this).val('');
				document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
				document.getElementById('archivoPlano').src = "";
				document.getElementById('plano').src = "";
				break;
	    }
	});
	
	function readURL() {
		document.getElementById("planoCambiado").value = "1";
		var file = document.getElementById("archivoPlano").files[0];
		var reader = new FileReader();
	    reader.onloadend = function() {
			document.getElementById('plano').src = reader.result ;        
			}
		if(file) {
			reader.readAsDataURL(file);
		} 
	}
});
</script>


<!-- Gallery -->
<script>
var slideIndex = 1;

var imageNumber = 0;
var videoNumber = 0;

var filesNumber = imageNumber + videoNumber;

var multimedia = [];

var slideIndex = 0;
showDivs(slideIndex);

function nextGalleryItem(n) {
    showDivs(slideIndex += n);
}

function showDivs(n) {
    var i;
    if (n >= filesNumber) {slideIndex = 0}
    if (n < 0) {slideIndex = filesNumber - 1};
    if (multimedia.length == 0) {
    	document.getElementById('imagenGaleria').src = '';
    	hideGalleryVideo();
    	return;
    }
    multi = multimedia[slideIndex];
    if (multi.imagen == 1) {
		hideGalleryVideo();
		document.getElementById('imagenGaleria').src = multi.src;
	} else {
		hideGalleryImage();
	}
}

function hideGalleryImage() {
	document.getElementById('imagenGaleria').style.display = 'none';
	document.getElementById('videoGaleria').style.display = 'block';
}

function hideGalleryVideo() {
	document.getElementById('imagenGaleria').style.display = 'block';
	document.getElementById('videoGaleria').style.display = 'none';
}

function hideGalleryErrorMessages() {
	document.getElementById('mensajeHayVideo').style.display = 'none';
	document.getElementById('mensajeCincoArchivos').style.display = 'none';
	document.getElementById('mensajeTamanoImagen').style.display = 'none';
	document.getElementById('mensajeTamanoVideo').style.display = 'none';
	document.getElementById('mensajeUnaImagen').style.display = 'none';
}

/*--------Galería-----------*/

$(document).ready(function() {
	<c:forEach items="${atraccion.listaImagenes}" var="imagenAtraccion">
	    var imAt = new Object();
	    imAt.src = "${pageContext.request.contextPath}/imagenAtraccion?id=" + '${imagenAtraccion.id}';
	    imAt.imagen = 1;
	    imAt.idImagen = ${imagenAtraccion.id};
	    multimedia.push(imAt);
	    imageNumber += 1;
	</c:forEach>

	<c:if test="${atraccion.video != null}">
		var imAt = new Object();
	    imAt.src = "${pageContext.request.contextPath}/videoAtraccion?id=" + '${atraccion.id}';
	    imAt.imagen = 0;
	    multimedia.push(imAt);
		videoNumber = 1;
		video = document.getElementById('videoGaleria');
		var source = document.createElement('source');
	    source.src = "${pageContext.request.contextPath}/videoAtraccion?id=" + '${atraccion.id}';
	    source.type = "video/mp4";
		video.appendChild(source);
	</c:if>
	
	<c:if test="${atraccion.audioEN != null}">
		var audio = document.getElementById('audio');
	    audio.src = "${pageContext.request.contextPath}/audioAtraccion?id=" + '${atraccion.id}';
	</c:if>
	
	filesNumber = imageNumber + videoNumber;
	nextGalleryItem(0);

	var posiblesId = [0,1,2,3,4]; 

	document.getElementById('eliminarImagen').onclick = function() {
		hideAllAtractionErrorMessages();
		if (filesNumber == 0) {
			return;
		}
		unArchivo = multimedia[slideIndex];
		if (unArchivo.idImagen != null) {
			console.log("IMAGEN MODIFICADA");
			document.getElementById('imagenesCambiadas').value += unArchivo.idImagen + ';';
		}
		if (unArchivo.imagen == 1) {
			imageNumber -= 1;
		} else {
			videoNumber = 0;
			if (unArchivo.file != null) {
				var eliminado = unArchivo.file;
				eliminado.parentNode.removeChild(eliminado);
			}
			document.getElementById('videoCambiado').value = 1;
		}
		if (unArchivo.idNumero != null) {
			posiblesId.push(unArchivo.idNumero);
			var element = document.getElementById(unArchivo.id);
			element.parentNode.removeChild(element);
		}
		filesNumber -= 1;
		multimedia.splice(slideIndex, 1);
		slideIndex -=1;
		filesNumber = imageNumber + videoNumber;
		nextGalleryItem(slideIndex);
	}
	
	document.getElementById('atraction-get-gallery-file').onclick = function() {
		hideAllAtractionErrorMessages();
		input = document.createElement('input');
		input.type='file';
		input.id = 'archivoGaleria';
		container = document.getElementById("container");
		container.appendChild(input);
		document.getElementById('archivoGaleria').addEventListener('change', readURL, true);
		input.click();
	};
	
	function readURL() {
		hideGalleryErrorMessages();
		console.log("READ");
		document.getElementById('archivoGaleria').style.display = 'none';
		var file = document.getElementById("archivoGaleria").files[0];
		val = file.name;
		container = document.getElementById("container");
		var imageVideo = [];
		isVideo = false;
		videoType = '';
		ext = val.substring(val.lastIndexOf('.') + 1).toLowerCase()
		switch(ext){
	    	case 'gif': case 'jpg': case 'png': case 'jpeg': case 'bmp': 
	        	if (filesNumber == 5) {
	        		document.getElementById('mensajeCincoArchivos').style.display = 'block';
	        		elem = document.getElementById('archivoGaleria');
	        		elem.parentNode.removeChild(elem);
	        		return;
	        	}
	        	if (file.size > (50 * 1024)) {
	        		document.getElementById('mensajeTamanoImagen').style.display = 'block';
	        		elem = document.getElementById('archivoGaleria');
	        		elem.parentNode.removeChild(elem);
	        		return;
	        	}
	        	
	        	document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	        	document.getElementById('mensajeHayVideo').style.display = 'none';
	        	document.getElementById("mensajeUnaImagen").style.display = 'none';
	        	document.getElementById('mensajeTamanoImagen').style.display = 'none';
	        	tagImagen = document.createElement('img');
	        	imageVideo.file = tagImagen;
	        	document.getElementById('archivoGaleria').style.display = 'none';
	        	document.getElementById('archivoGaleria').name = 'archivoGaleria' + posiblesId[0];
				document.getElementById('archivoGaleria').id = 'archivoGaleria' + posiblesId[0];
				imageVideo.id = 'archivoGaleria' + posiblesId[0];
				imageNumber = imageNumber + 1;
	        	break;
	        case 'mp4': case 'avi': 
	        	if (videoNumber == 1) {
	        		document.getElementById('mensajeHayVideo').style.display = 'block';
	        		elem = document.getElementById('archivoGaleria');
	        		elem.parentNode.removeChild(elem);
	        		return;
	        	}
	        	if (filesNumber == 5) {
	        		document.getElementById('mensajeCincoArchivos').style.display = 'block';
	        		elem = document.getElementById('archivoGaleria');
	        		elem.parentNode.removeChild(elem);
	        		return;
	        	}
	        	if (file.size > (10 * 1024 * 1024)) {
	        		document.getElementById('mensajeTamanoVideo').style.display = 'block';
	        		elem = document.getElementById('archivoGaleria');
	        		elem.parentNode.removeChild(elem);
	        		return;
	        	}
	        	document.getElementById('mensajeHayVideo').style.display = 'none';
	        	isVideo = true;
	        	if (ext == 'mp4') {
	        		videoType='video/mp4';
	        	} else {
	        		videoType='video/avi';
	        	}
	        	document.getElementById('archivoGaleria').name = 'unVideo';
	        	document.getElementById('archivoGaleria').id = 'archivoGaleria' + posiblesId[0];	
	        	imageVideo.id = 'archivoGaleria' + posiblesId[0];        
	        	break;
	        default:
	            $(this).val('');
				document.getElementById("mensajeImagenIncorrectaError").style.display = 'block';
				document.getElementById('archivoGaleria').value = "" ;
				document.getElementById('galeria').src = "" ;
				break;
	    }
		var reader = new FileReader();
	    reader.onloadend = function(){
	    	imageVideo.src = reader.result;
	    	if (!isVideo) {
	    		imageVideo.imagen = 1;
				document.getElementById('imagenGaleria').src = reader.result;
				document.getElementById('imagenGaleria').style.display = 'block';
				document.getElementById('videoGaleria').style.display = 'none';
			} else {
				imageVideo.imagen = 0;
				videoNumber = 1;
				document.getElementById('imagenGaleria').style.display = 'none';
				video = document.getElementById('videoGaleria');
				video.style.display = 'block';
				var source = document.createElement('source');
			    source.src = reader.result;
			    source.type = videoType;
			    imageVideo.file = source;
				video.appendChild(source);
			}
			imageVideo.idNumero = posiblesId[0];
			console.log("ID USADO: " + imageVideo.id);
			multimedia.push(imageVideo);
			posiblesId.splice(0,1);
			filesNumber = imageNumber + videoNumber;
			slideIndex = filesNumber - 1;
		}
		if(file) {
			reader.readAsDataURL(file);
		}
	}
});
</script>


<!-- Audioguía -->
<script>
$(document).ready(function() {
	document.getElementById('atraction-get-audio-file').onclick = function() {
		hideAllAtractionErrorMessages();
		document.getElementById('archivoAudioguia').addEventListener('change', readURL, true);
		var fileButton = document.getElementById('archivoAudioguia');
		fileButton.click();
	};
	
	$("#archivoAudioguia").change(function() {
	    var val = $(this).val();
	    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
	        case 'mp3':
	        	document.getElementById("mensajeAudioIncorrectoError").style.display = 'none';
	        	break;
	        default:
	            $(this).val('');
				document.getElementById("mensajeAudioIncorrectoError").style.display = 'block';
				document.getElementById('archivoAudioguia').value = "" ;
				document.getElementById('audio').src = "" ;
				break;
	    }
	});
	
	function readURL(){
		var file = document.getElementById("archivoAudioguia").files[0];
		var reader = new FileReader();
	    reader.onloadend = function(){
			document.getElementById('audio').src = reader.result;
		}
		if(file) {
			reader.readAsDataURL(file);
		} 
	}
});
</script>


<c:set var="latitud_atraccion">
	${atraccion.latitud}
</c:set>

<c:set var="longitud_atraccion">
	${atraccion.longitud}
</c:set>

<c:set var="latitud_ciudad">
	${atraccion.ciudad.latitud}
</c:set>

<c:set var="longitud_ciudad">
	${atraccion.ciudad.longitud}
</c:set>

<!-- Mapa -->
<script>
var out_of_range = false, map, marker, autocomplete, infowindow, input, aux_lat, aux_lng,
	map_lat = document.formModificar.latitud.value,
	map_lng = document.formModificar.longitud.value,
	hubo_click = false;

function updateCoordinatesForm() {
	document.formModificar.latitud.value = map_lat;
	document.formModificar.longitud.value = map_lng;
}

function hideOkAndCancelButtonsForCoordinates() {
	document.getElementById('ok-coordinates').style.display = "none";
    document.getElementById('cancel-coordinates').style.display = "none";
}

function setPosition(lat, lng) {
	var position = new google.maps.LatLng(lat, lng);
	marker.setPosition(position);
	hideOkAndCancelButtonsForCoordinates();
}

function saveCoordinates() {
	google.maps.event.clearInstanceListeners(map);
	if (hubo_click) {
		map_lat = aux_lat;
		map_lng = aux_lng;
	}
	setPosition(map_lat, map_lng);
	if (out_of_range) {
		far_away = true;
	}
	hideOkAndCancelButtonsForCoordinates();
	hideAllAtractionErrorMessages();
}

function cancelEditingCoordinates() {
	google.maps.event.clearInstanceListeners(map);
	setPosition(map_lat, map_lng);
	hideAllAtractionErrorMessages();
}

function editCoordinates() {
	hubo_click = false;
	hideAllAtractionErrorMessages();
	document.getElementById('ok-coordinates').style.display = "inline-block";
    document.getElementById('cancel-coordinates').style.display = "inline-block";
	autocomplete.addListener('place_changed', function() {
	    infowindow.close();
	    marker.setVisible(false);
	    var place = autocomplete.getPlace();
	    if (!place.geometry) {
	        window.alert("Autocomplete's returned place contains no geometry");
	        return;
	    }
	
	    // If the place has a geometry, then present it on a map.
	    if (place.geometry.viewport) {
	        map.fitBounds(place.geometry.viewport);
	    } else {
	        map.setCenter(place.geometry.location);
	        map.setZoom(17);  // Why 17? Because it looks good.
	    }
	    marker.setPosition(place.geometry.location);
	    marker.setVisible(true);
	
	    // Se guardan las coordenadas
	    aux_lat = place.geometry.location.lat();
	    aux_lng = place.geometry.location.lng();
	
	    var address = '';
	    if (place.address_components) {
	        address = [
	            (place.address_components[0] && place.address_components[0].short_name || ''),
	            (place.address_components[1] && place.address_components[1].short_name || ''),
	            (place.address_components[2] && place.address_components[2].short_name || '')
	        ].join(' ');
	    }
	
	    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
	    infowindow.open(map, marker);
	});
	
	// Al clickear en el mapa, se guardan las coordenadas y se dibuja la ubicación
	google.maps.event.addListener(map, 'click', function(event) {
		marker.setVisible(false);
		marker.setPosition(event.latLng);
	    marker.setVisible(true);

		// Se guardan las coordenadas
		aux_lat = event.latLng.lat();
		aux_lng = event.latLng.lng();
	   	
	   	// Se verifica si la ubicación seleccionada se encuentra a más de 15km.
	   	var city_coordinates = new google.maps.LatLng(${latitud_ciudad}, ${longitud_ciudad});
		if (google.maps.geometry.spherical.computeDistanceBetween(event.latLng, city_coordinates) < 15000) {
			document.getElementById("mensajeUbicacionLejana").style.display = 'none';
			out_of_range = false;
	    } else {
	    	document.getElementById("mensajeUbicacionLejana").style.display = 'block';
	    	out_of_range = true;
	    }
		hubo_click = true;
	});
}

function initMap() {
   	map = new google.maps.Map(document.getElementById('atraction-map'), {
   	    center: {lat: ${latitud_atraccion}, lng: ${longitud_atraccion}},
   	    zoom: 13
   	});
   	
    input = (document.getElementById('atraction-map-input'));
   	map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

   	autocomplete = new google.maps.places.Autocomplete(input, {types: []});
   	autocomplete.bindTo('bounds', map);
   	
   	infowindow = new google.maps.InfoWindow();
   	marker = new google.maps.Marker({
   	    map: map
   	});

    marker.setPosition(map.center);
   	marker.setVisible(true);
}
</script>
		
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places,geometry&callback=initMap&language=es" async defer></script>

</body>
</html>
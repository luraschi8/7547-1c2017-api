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
	<title>Trips - Nueva atracción</title>
</head>
<body>

	<h1 class="page-header atraction-new-page-header" style="margin-left: 5rem">Nueva atracción</h1>

<div id="attractionForm">
	<form:form id ="formNuevo" name="formNuevo" action="atraccionNuevoValidar" method="post" commandName="atraccion" enctype="multipart/form-data">
	
		<div class="atraction-new-form" style="width: 100%; display: inline-block; overflow: hidden;"> 
		
			<!-- Bloque izquierdo -->
			<div class="atraction-main-information-and-map" style="float:left; margin-top:-1rem">
	
				<!-- Información principal -->
				<div class="atraction-main-information">
					<input type="hidden" id="idCiudad" name="idCiudad" value="${atraccion.atraccion.ciudad.id}"/>
					<input type="hidden" id="latitudCiudad" name="latitudCiudad" value="${atraccion.atraccion.ciudad.latitud}"/>
	
					<form:input type="hidden" id="latitud" name="latitud" path="atraccion.latitud"/>
					<form:input type="hidden" id="longitud" name="longitud" path="atraccion.longitud"/>
					<input type="hidden" id="id" name="id" value="${atraccion.id}"/>
					
					<div>
						<form:label class="atraction-label atraction-language-label" path="idioma">Seleccione el idioma</form:label>
						  	<div>
							  	<c:choose>
							  		<c:when test="${idioma =='EN'}">
							  			<input type="radio" id="langES" name="idioma" path="idioma" value="ES" style="margin: 4px" onclick="cambiarIdioma()">Español
									  	<input type="radio" id="langEN" name="idioma" path="idioma" value="EN" style="margin: 4px; margin-left: 15px;" checked="checked" onclick="cambiarIdioma()">Inglés
							  		</c:when>
							  		<c:otherwise>
							  			<input type="radio" id="langES" name="idioma" path="idioma" value="ES" style="margin: 4px" checked="checked" onclick="cambiarIdioma()">Español
									  	<input type="radio" id="langEN" name="idioma" path="idioma" value="EN" style="margin: 4px; margin-left: 15px;" onclick="cambiarIdioma()">Inglés
							  		</c:otherwise>	
							  			
							  	</c:choose>
							</div>
					</div>
					
					<div>
						<form:label class="atraction-label atraction-name-label" path="atraccion.nombre">Nombre</form:label><font color="red"> *</font>
					</div>
					<!-- -->
					<div>
						<form:input path="atraccion.nombre" type="text" onkeydown="calculateMaxLength('#nombre', MAX_NOMBRE_ATRACCION)" rows="1" id="nombre" name="nombre" class="atraction-box atraction-name-box" placeholder="Ingrese el nombre de la atracción"/>
					</div>
					
					<div class="alert alert-danger fade in atraction-alert" id="mensajeNombreVacio" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> No se ha seleccionado un nombre para la atracción.
					</div>
					
					<div>
						<form:label class="atraction-label atraction-description-label" path="descripcion">Descripción</form:label><font color="red"> *</font>
					</div>
					<div>
						<textarea onkeydown="calculateMaxLength('#descripcion', MAX_DESCRIPCION_ATRACCION)" rows="4" id="descripcion" path="descripcion" name="descripcion" class="atraction-box atraction-descripcion-box"  placeholder="Ingrese la descripcion de la atracción" required></textarea>
					</div>
					
					<div class="alert alert-danger fade in atraction-alert" id="mensajeDescripcionVacia" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> No se ha seleccionado una descripción para la atracción.
					</div>
					
					<div>
						<form:label class="atraction-label atraction-schedule-label" path="horario">Horario</form:label>
					</div>
					<div>
						<textarea onkeydown="calculateMaxLength('#horario', MAX_HORARIO_ATRACCION)" rows="3" id="horario" path="horario" name="horario" class="atraction-box atraction-schedule-box"  placeholder="Ingrese el horario de la atracción"></textarea>
					</div>
					
					<div>
						<form:label class="atraction-label atraction-cost-label" path="precio">Precio</form:label>
					</div>
					<div>
						<textarea onkeydown="calculateMaxLength('#precio', MAX_PRECIO_ATRACCION)" rows="3" id="precio" path="precio" name="precio" class="atraction-box atraction-cost-box"  placeholder="Ingrese el costo de la atracción"></textarea>
					</div>
					
					<div>
						<form:label class="atraction-label atraction-recorrible-label" path="atraccion.recorrible">&iquestEs recorrible?</form:label>
						  	<div>
							  	<input type="radio" id="es-recorrible" name="recorrible" path="atraccion.recorrible" value="1" style="margin: 4px" onclick="$('#blueprints').show(); $('#view-atraction-points-of-interest-panel').show();">Si
							  	<input type="radio" id="no-es-recorrible" name="recorrible" path="atraccion.recorrible" value="0" checked="checked" style="margin: 4px; margin-left: 15px;" onclick="$('#blueprints').hide(); $('#view-atraction-points-of-interest-panel').hide();">No
							</div>
					</div>
				</div>
			
				<!-- Plano -->
				<div class="atraction-blueprints-group">
					<!-- Plano -->
					<div id="blueprints" style="display: none;style="float:left"">
						<div>
							<form:label class="atraction-label atraction-blueprints-label" path="atraccion.plano">Plano</form:label><font color="red"> *</font>
						</div>
						<div class="atraction-blueprints-box" style="float:left">
							<img id="plano" style="width:100%; height:100%">
							<button type="button" class="btn btn-default btn-sm atraction-get-blueprints" id="atraction-get-blueprints">
								<span class="glyphicon glyphicon-pencil"></span>
							</button>
							<input id="planoCambiado" name="planoCambiado" type="hidden" value="0">
							<input type="file" name="archivoPlano" id="archivoPlano"/>
						</div>
		
						<div class="atraction-blueprints-alert-messages">
							<div class="alert alert-danger fade in atraction-alert" id="mensajePlanoNecesario" style="display: none;">
							 	<a class="close" data-dismiss="alert" aria-label="close"></a>
							 	<strong>&iexclError!</strong> La atracción es recorrible. Debe proporcionarse un plano.
							</div>
							<div class="alert alert-danger fade in atraction-alert" id="mensajePlanoIncorrectoError" style="display: none;">
							 	<a class="close" data-dismiss="alert" aria-label="close"></a>
							 	<strong>&iexclError!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otra.
							</div>
						</div>
					</div>
					
					<!-- Galería -->
					<div style="clear: left">
						<div>
							<label class="atraction-label atraction-gallery-label">Galería</label><font color="red"> *</font>
						</div>
						<div id ="container" class="atraction-gallery atraction-gallery-box">
							<img class="atraction-gallery" id="imagenGaleria" style="width:100%; height:100%;">
							<video id="videoGaleria" style="width:100%; height:100%;display:none" controls >
							</video>
							
							<div class="atraction-gallery-buttons">
								<button type="button" class="w3-button w3-display-left atraction-gallery-slide-left" onclick="nextGalleryItem(-1)">&lt;</button>
								<button type="button" class="w3-button w3-display-right atraction-gallery-slide-right" onclick="nextGalleryItem(+1)">&#10095;</button>
								<input type="button" id="atraction-get-gallery-file" class="btn btn-default btn-atraction-get-gallery-file" value="+">
							    
							    <button type="button" class="btn btn-default btn-sm atraction-erase-multimedia" id="eliminarImagen">
									<span class="glyphicon glyphicon-erase"></span>
								 </button>
							</div>
						</div>
					</div>
					
					<div class="alert alert-danger fade in atraction-alert" id="mensajeHayVideo" style="display: none;float:left">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> Ya se ha seleccionado un video anteriormente! Solo se puede seleccionar uno!
					</div>
					
					<div class="alert alert-danger fade in atraction-alert" id="mensajeCincoArchivos" style="display: none;float:left">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> Ya se han seleccionado 5 archivos, no se pueden agregar mas!
					</div>
					
					<div class="alert alert-danger fade in atraction-alert" id="mensajeTamanoImagen" style="display: none;float:left">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> La imagen no puede pesar mas de 50KB!
					</div>
					
					<div class="alert alert-danger fade in atraction-alert" id="mensajeTamanoVideo" style="display: none;float:left">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> El video no puede pesar mas de 10MB!
					</div>
					
					<div class="alert alert-danger fade in atraction-alert" id="mensajeUnaImagen" style="display: none;float:left">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> Tiene que estar presente una imagen por lo menos!
					</div>
					
					<div class="alert alert-danger fade in atraction-alert" id="mensajeImagenIncorrectaError" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> El archivo no es una imagen/video. Por favor, introduzca otra.
					</div>
					
					<!-- Audioguía -->
					<div class="new-atraction-audio-group">
						<label class="atraction-label atraction-audio-label">Audioguía</label>
						<input type="hidden" id="audioCambiado" name="audioCambiado" value=0>
						<div>
							<!-- Reproducir audioguía -->
							<div style="float:left">
								<audio id="audio" controls>
								    <source type="audio/mpeg">
								</audio> 
							</div>
							
							<!-- Botón agregar audioguía -->
							<div style="text-align:center; float:right;">
							
								<button type="button" class="btn btn-default btn-sm btn-atraction-get-audio-file" id="atraction-get-audio-file">
									<span class="glyphicon glyphicon-pencil"></span>
								 </button>
							
								<button type="button" class="btn btn-default btn-sm btn-atraction-erase-audio-file" id="atraction-erase-audio-file">
									<span class="glyphicon glyphicon-erase"></span>
								 </button>

								<input type="file" name="archivoAudioguia" id="archivoAudioguia"/>
							</div>
						</div>
					</div>
					
					<div class="alert alert-danger fade in atraction-alert-incorrect-audio" id="mensajeAudioIncorrectoError" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo seleccionado no es un audio válido. Por favor, introduzca otro.
					</div>
					
					<div class="alert alert-danger fade in atraction-alert-incorrect-audio" id="mensajeAudioTamano" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo pesa mas de 3MB. Por favor, seleccione uno de menor tamaño.
					</div>
					
				</div>
			</div>
			
			<!-- Bloque derecho -->
			<div class="atraction-right-block">
				<!-- Mapa -->
				<div style="float: right">
					<label>Ubicación</label><font color="red"> *</font>
					<input id="atraction-map-input" class="atraction-map-controls" type="text" placeholder="Ingresar ubicación">
					<div id="atraction-map"></div> 
					
					<div class="alert alert-danger fade in new-atraction-alert-no-location" id="mensajeUbicacionVacia" style="display: none">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclError!</strong> No se ha seleccionado una ubicación para la atracción.
					</div>
					
					<div class="alert alert-warning fade in new-atraction-alert-no-location" id="mensajeUbicacionLejana" style="display: none">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclAdvertencia!</strong> La atracción seleccionada está a más de 15km de la ciudad actual.
					</div>	
				</div>
				
				<!-- Tabla puntos de interés y obras -->
				<div id="view-atraction-points-of-interest-panel" style="float:right; display: none" class="panel panel-primary view-atraction-panel">
					<div style="text-align:center">
						<input id="botonPuntosDeInteres" class="btn btn-ver-puntos-y-obras" type="button" value="Puntos de interés y obras" />
						
						<form class="form-horizontal maxwid" id="formAgregarPuntoDeInteres" name="formAgregarPuntoDeInteres" action="puntoDeInteresNuevo" method="post">
							<input id="botonAgregarPuntoDeInteres" class="btn btn-agregar-puntos-y-obras btn-nuevo-punto-de-interes" type="button" value="+" onclick="openNewPointOfInterestForm()"/>
						</form>
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
					<font color="red" size="1">&nbsp;&nbsp;&nbsp;&nbsp;* Debe añadirse al menos un punto de interés</font>
				</div>
				<div class="alert alert-danger fade in atraction-alert-point-of-interest-needed" id="mensajePuntoDeInteresNecesario" style="display: none; clear: right; float: right; margin-right: 5rem;">
				 	<a class="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>&iexclError!</strong> La atracción es recorrible. Debe haber por lo menos un punto de interés.
				</div>
			</div>
		</div>
	
		<div class="alert alert-danger fade in atraction-alert-already-exists" id="mensajeNombreRepetido" style="display: none;">
		 	<a class="close" data-dismiss="alert" aria-label="close"></a>
		 	<strong>&iexclError!</strong> La atracción seleccionada ya se encuentra registrada. Seleccione otra.
		</div>
		<br>
		<font style="margin-left: 5rem;" color="red" size="1">Los campos indicados con * son obligatorios</font>
	</form:form>
</div>

<form:form id="formAtras" action="ciudadVer?idCiudad=${atraccion.atraccion.ciudad.id}" method="post"></form:form>
<div class="btn-final" style="text-align:center;">
	<input id="botonAtras" class="btn btn-default" type="button" value="Cancelar" />
	<input id="botonNuevo" class="btn btn-default btn-primary" type="button" value="Guardar" />
</div>

<div id="atraction-point-of-interest-popup-form" style="width: 50%; height: 100%">
	<div style="margin-left: 5%; margin-right: 5%; width: 90%; height: 90%">
		<form:form class="atraction-new-point-of-interest" style="width: 100%; height: 100%" id="formNuevoPuntoDeInteres" name="formNuevoPuntoDeInteres" action="nuevoPuntoDeInteres" method="post" commandName="puntoDeInteres" enctype="multipart/form-data">
			<h2 style="width: 100%; height: 8%">Nuevo punto de interés</h2>
			
			<div style="width: 100%; height: 11%">
				<div style="display: inline-block;">
					<label class="atraction-label" path="nombre">Nombre</label><font color="red"> *</font>
				</div>
				<button style="display: none" type="button" class="btn btn-default btn-sm" id="puntoEditNameButton" onclick="editField('#puntoNombre', 'ok-nombre-punto', 'cancel-nombre-punto', 'mensajeNombreVacioPuntoDeInteresError', true);">
					<span class="glyphicon glyphicon-pencil"></span>
				</button>
				<button type="button" class="btn btn-default btn-sm" style="display:none; background-color: red;" id="cancel-nombre-punto" onclick="cancelField('#puntoNombre', 'ok-nombre-punto', 'cancel-nombre-punto')">
					<span class="glyphicon glyphicon-remove"></span>
				</button>
				<button type="button" class="btn btn-default btn-sm" style="display:none; background-color: green;" id="ok-nombre-punto" onclick="saveField('#puntoNombre', 'ok-nombre-punto', 'cancel-nombre-punto', 'mensajeNombreVacioPuntoDeInteresError', true)">
					<span class="glyphicon glyphicon-ok"></span>
				</button>
				<div>
					<textarea onkeydown="calculateMaxLength('#puntoNombreTextarea', MAX_NOMBRE_PUNTO_DE_INTERES)" rows="1" id="puntoNombreTextarea" path="nombre" name="puntoNombreTextarea" class="atraction-poi-box"  placeholder="Ingrese el nombre del punto de interés" required="required"/></textarea>
				</div>
				<div>
					<p style="display: none;" id="puntoNombre" name="puntoNombre" class="atraction-poi-box"/></p>
				</div>
			</div>
			<div class="alert alert-danger fade in atraction-poi-alert" id="mensajeNombreVacioPuntoDeInteresError" style="display: none; margin-top: 2%;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> El nombre no puede estar vacío.
			</div>
			
			<div style="width: 100%; height: 15%;">
				<div style="display: inline-block;">
					<label class="atraction-label" path="descripcion">Descripción</label><font color="red"> *</font>
				</div>
				
				<button style="display: none" type="button" class="btn btn-default btn-sm" id="puntoEditDescriptionButton" onclick="editField('#puntoDescripcion', 'ok-descripcion-punto', 'cancel-descripcion-punto', 'mensajeDescripcionVaciaPuntoDeInteresError', true);">
					<span class="glyphicon glyphicon-pencil"></span>
				</button>
				<button type="button" class="btn btn-default btn-sm" style="display:none; background-color: red;" id="cancel-descripcion-punto" onclick="cancelField('#puntoDescripcion', 'ok-descripcion-punto', 'cancel-descripcion-punto')">
					<span class="glyphicon glyphicon-remove"></span>
				</button>
				<button type="button" class="btn btn-default btn-sm" style="display:none; background-color: green;" id="ok-descripcion-punto" onclick="saveField('#puntoDescripcion', 'ok-descripcion-punto', 'cancel-descripcion-punto', 'mensajeNombreVacioPuntoDeInteresError', true)">
					<span class="glyphicon glyphicon-ok"></span>
				</button>
				
				<div>
					<textarea onkeydown="calculateMaxLength('#puntoDescripcionTextarea', MAX_DESCRIPCION_PUNTO_DE_INTERES)" id="puntoDescripcionTextarea" path="descripcion" name="puntoDescripcionTextarea" class="atraction-poi-box"  placeholder="Ingrese la descripción del punto de interés" required="required"/></textarea>
				</div>
				<div>
					<p id="puntoDescripcion" name="puntoDescripcion" class="atraction-poi-box"/></p>
				</div>
			</div>
			<div class="alert alert-danger fade in atraction-poi-alert" id="mensajeDescripcionVaciaPuntoDeInteresError" style="display: none; margin-top: 2%;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> La descripción no puede estar vacía.
			</div>
			
			<div style="width: 100%; height: 33%;">
				<div style="width: 100%; height: 18%">
					<label class="atraction-label" path="imagen">Imagen</label><font color="red"> *</font>
				</div>
				<div class="atraction-point-of-interest-image-box">
					<img id="puntoImagen" style="width:100%; height:100%;">
					<button type="button" class="btn btn-default btn-sm atraction-poi-get-image" id="puntoGetImagen">
						<span class="glyphicon glyphicon-pencil"></span>
					</button>
					<input id="puntoImagenCambiada" name="puntoImagenCambiada" type="hidden" value="0">
					<input type="file" name="puntoArchivoImagen" id="puntoArchivoImagen" style="display: none"/>
				</div>
			</div>
			
			<div class="alert alert-danger fade in atraction-poi-alert" id="mensajeImagenIncorrectaPuntoDeInteresError" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otro.
			</div>
			
			<div class="alert alert-danger fade in atraction-poi-alert" id="mensajeImagenVaciaPuntoDeInteresError" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> Por favor seleccione una imagen.
			</div>
			
			<div style="width: 100%; height: 15%">
				<div style="width: 100%; height: 40%">
					<label class="atraction-label" path="audioES">Audioguía</label>
				</div>
				<input type="hidden" id="audioCambiadoPdi" name="audioCambiadoPdi" value=0>
				<div style="width: 100%; height: 60%">
					<!-- Reproducir audioguía -->
					<div style="float: left; width: 85%; height: 50%">
						<audio id="puntoAudio" style="width: 100%;" controls>
						    <source type="audio/mpeg">
						</audio> 
					</div>
					
					<!-- Botón agregar audioguía -->
					<div style="float: right; width: 15%; height: 50%; text-align: right;">
						<button type="button" class="btn btn-default btn-sm btn-atraction-get-pdi-audio-file" id="puntoGetAudio">
							<span class="glyphicon glyphicon-pencil"></span>
						 </button>
					
						<button type="button" class="btn btn-default btn-sm btn-atraction-erase-poi-audio-file" id="borrarAudioPdi">
							<span class="glyphicon glyphicon-erase"></span>
						 </button>
	
						<input type="file" name="archivoAudioguiaPdi" id="archivoAudioguiaPdi"/>
					</div>
				</div>
			</div>
			
			<div class="alert alert-danger fade in atraction-poi-alert" id="mensajeAudioPdiIncorrectoError" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El archivo seleccionado no es un audio válido. Por favor, introduzca otro.
			</div>
			
			<div class="alert alert-danger fade in atraction-poi-alert" id="mensajeAudioPdiTamano" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El archivo pesa más de 3MB. Por favor, seleccione uno de menor tamaño.
			</div>
			
			<div class="alert alert-danger fade in" id="mensajeNombrePuntoDeInteresRepetido" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El nombre del punto de interés ingresado ya se encuentra registrado. Por favor, ingrese otro.
			</div>
			<br>
			<font style="margin-left: 1%;" color="red" size="1">Los campos indicados con * son obligatorios</font>
			
			<div class="btn-final-pdi-form" style="width: 100%; text-align:center; clear:both;">
				<input id="botonCancelarPuntoDeInteres" class="btn btn-default" type="button" value="Cancelar" onclick="closeNewPointOfInterestForm();"/>
				<input id="botonGuardarPuntoDeInteres" class="btn btn-default btn-primary" type="button" value="Guardar"/>
				<input id="botonGuardarEdicionPuntoDeInteres" style="display: none" class="btn btn-default btn-primary" type="button" value="Guardar"/>
			</div>
		</form:form>
	</div>
</div>

<form style="display: none" class="form-city-add-atraction" id="formAgregarAtraccion" name="formAgregarAtraccion" action="atraccionNuevo" method="post">
	<input id="idCliudad" name="idCiudad" type="hidden" value="${atraccion.atraccion.ciudad.id}"/>
	<input id="latitudCiudad" name="latitudCiudad" type="hidden" value="${atraccion.atraccion.ciudad.latitud}"/>
	<input id="longitudCiudad" name="longitudCiudad" type="hidden" value="${atraccion.atraccion.ciudad.longitud}"/>
	<input id="idioma" name="idioma" type="hidden" value="${idioma}"/>
</form>


<script src="${pageContext.request.contextPath}/js/puntoInteres.js"></script>

<!-- Definición de constantes -->
<script>
const MAX_NOMBRE_ATRACCION = "50";
const MAX_DESCRIPCION_ATRACCION = "250";
const MAX_HORARIO_ATRACCION = "50";
const MAX_PRECIO_ATRACCION = "50";

$("#nombre").attr("maxlength", MAX_NOMBRE_ATRACCION);
$("#descripcion").attr("maxlength", MAX_DESCRIPCION_ATRACCION);
$("#horario").attr("maxlength", MAX_HORARIO_ATRACCION);
$("#precio").attr("maxlength", MAX_PRECIO_ATRACCION);
</script>

<script>
$('#botonAtras').on('click', function(e) {
	e.preventDefault();
	document.getElementById("formAtras").submit();
});

$('#botonNuevo').on('click', function(e) {
	e.preventDefault();
	document.getElementById("mensajeNombreRepetido").style.display = 'none';
	document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	document.getElementById("mensajeAudioIncorrectoError").style.display = 'none';
	hideAllAtractionErrorMessages();
 	validarAtraccionRepetida();
});

function checkEmptyFields(idiomaACambiar) {
	var empty_fields = true;
	if ((document.getElementById("nombre").value != "") || (document.getElementById("descripcion").value != "") ||
			(document.getElementById("horario").value != "") || (document.getElementById("precio").value != "") ||
			(document.getElementById("latitud").value != "0.0") || (document.getElementById("longitud").value != "0.0") ||
			(document.getElementById("audio").src != "") || (document.getElementById('es-recorrible').checked)
			|| (imageNumber != 0)) {
		empty_fields = false;
	}
	if (!empty_fields) {
		bootbox.confirm({
		    message: "Si cambia de idioma se perderá la información cargada. ¿Desea continuar?",
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
		        	document.formAgregarAtraccion.idioma.value = idiomaACambiar;
		        	document.getElementById("formAgregarAtraccion").submit();
		        } else {
		        	if (idiomaCheck == "ES") {
		        		$("input[name='idioma']:checked").val("EN");
					} else {
						$("input[name='idioma']:checked").val("ES");
					}
			    }
		    }
		});
	}
}

function validarElemento(elemento, mensaje, hayError) {
	if ((document.getElementById(elemento).value == '') && (!hayError)) {
		document.getElementById(mensaje).style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById(mensaje).style.display = 'none';
	}
	return hayError;
}

function validarUbicacion(hay_ubicacion, mensaje, hayError) {
	if ((!hay_ubicacion) && (!hayError)) {
		document.getElementById(mensaje).style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById(mensaje).style.display = 'none';
	}
	return hayError;
}

//Para validar si se ha o no elegido una ubicación
var location_selected = false;

function validarPlano(plano, mensaje, hayError) {
	if ((document.getElementById(plano).src == "") && (!hayError)) {
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
	hayError = validarUbicacion(location_selected, "mensajeUbicacionVacia", hayError);
	
	if (document.getElementById('es-recorrible').checked) {
		hayError = validarPlano('plano', 'mensajePlanoNecesario', hayError);
		if (table.data().count() == 0) {
			hayError = 1;
			document.getElementById("mensajePuntoDeInteresNecesario").style.display = 'block';
		}
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
		"id": document.formNuevo.idCiudad.value,
	}
	
	var a = {
		"ciudad": ciudad,
		"latitud": document.formNuevo.latitud.value,
		"longitud": document.formNuevo.longitud.value,
		"nombre": document.formNuevo.nombre.value
	}
	
	var json = {
		"atraccion": a,
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
				document.formNuevo.recorrible.value = $("input[name='recorrible']:checked").val();
				document.formNuevo.idioma.value = $("input[name='idioma']:checked").val();
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
					        	document.getElementById("formNuevo").submit();
					        }
			    	    }
				    });
			  	} else {
			  		document.getElementById("formNuevo").submit();
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
	validateImage("atraction-get-blueprints", "archivoPlano", "plano", "mensajePlanoIncorrectoError");
});
</script>

<!-- Gallery -->
<script>

var imageNumber = 0;
var videoNumber = 0;

var filesNumber = imageNumber + videoNumber;

var multimedia = [];

var slideIndex = 0;

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



/*--------Galería-----------*/

$(document).ready(function() {
	
	var posiblesId = [0,1,2,3,4];
	
	document.getElementById('eliminarImagen').onclick = function() {
		hideAllAtractionErrorMessages();
		if (filesNumber == 0) {
			return;
		}
		unArchivo = multimedia[slideIndex];
		if (unArchivo.imagen == 1) {
			imageNumber -= 1;
		} else {
			videoNumber = 0;
			var eliminado = unArchivo.file;
			eliminado.parentNode.removeChild(eliminado);
		}
		filesNumber -= 1;
		posiblesId.push(unArchivo.idNumero);
		var element = document.getElementById(unArchivo.id);
		element.parentNode.removeChild(element);
		multimedia.splice(slideIndex, 1);
		slideIndex -=1;
		filesNumber = imageNumber + videoNumber;
		nextGalleryItem(slideIndex);
	}
	
	
	document.getElementById('atraction-get-gallery-file').onclick = function() {
		input = document.createElement('input');
		input.type='file';
		input.id = 'archivoGaleria';
		container = document.getElementById("container");
		container.appendChild(input);
		document.getElementById('archivoGaleria').addEventListener('change', readURL, true);
		input.click();
	};
	
	function readURL(){
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
				elem = document.getElementById('archivoGaleria');
	        	elem.parentNode.removeChild(elem);
	        	return;
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
validateAudio("puntoGetAudio", "borrarAudioPdi", "archivoAudioguiaPdi", "puntoAudio", "audioCambiadoPdi", "mensajeAudioPdiTamano", "mensajeAudioPdiIncorrectoError");
validateAudio("atraction-get-audio-file", "atraction-erase-audio-file", "archivoAudioguia", "audio", "audioCambiado", "mensajeAudioTamano", "mensajeAudioIncorrectoError");
</script>

<c:set var="latitud_ciudad">
	${atraccion.atraccion.ciudad.latitud}
</c:set>

<c:set var="longitud_ciudad">
	${atraccion.atraccion.ciudad.longitud}
</c:set>

<c:set var="id">
	-1
</c:set>

<!-- Mapa -->
<script>
far_away = false;
function initMap() {
	var map = new google.maps.Map(document.getElementById('atraction-map'), {
		center: {lat: ${latitud_ciudad}, lng: ${longitud_ciudad}},
		zoom: 13
	});
	var input = (document.getElementById('atraction-map-input'));

	map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

	var autocomplete = new google.maps.places.Autocomplete(input, {types: []});
	autocomplete.bindTo('bounds', map);
      
	google.maps.event.addDomListener(input, 'keydown', function(e) { 
		if (e.keyCode == 13) { 
			e.preventDefault(); 
		}
	});

	var infowindow = new google.maps.InfoWindow();
	var marker = new google.maps.Marker({
		map: map,
	});

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
	document.formNuevo.latitud.value = place.geometry.location.lat();
	document.formNuevo.longitud.value = place.geometry.location.lng();
	location_selected = true;
	checkIfIsOutOfRange(place.geometry.location);

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
	google.maps.event.addListener(map, 'click', function( event ) {
		marker.setVisible(false);
		marker.setPosition(event.latLng);
		marker.setVisible(true);

	// Se guardan las coordenadas
		document.formNuevo.latitud.value = event.latLng.lat();
		document.formNuevo.longitud.value = event.latLng.lng();
		location_selected = true;
		checkIfIsOutOfRange(event.latLng);
	});
};

function checkIfIsOutOfRange(coordinates) {
	// Se verifica si la ubicación seleccionada se encuentra a más de 15km.
	var city_coordinates = new google.maps.LatLng(${latitud_ciudad}, ${longitud_ciudad});
   	if (google.maps.geometry.spherical.computeDistanceBetween(coordinates, city_coordinates) < 15000) {
		document.getElementById("mensajeUbicacionLejana").style.display = 'none';
   		far_away = false;
	} else {
		document.getElementById("mensajeUbicacionLejana").style.display = 'block';
		far_away = true;
	}
};

/* PUNTO DE INTERES  */
<c:set var="idioma">
	${idioma}
</c:set>
idiomaCheck = $("input[name='idioma']:checked").val();

$(document).ready(function() {
	var idioma = "${idioma}";
	if (idioma != "") {
		var idIdioma = "lang" + idioma;
		document.getElementById(idIdioma).checked = true;
	}
	console.log("IDIOMA: " + idioma);
});

function cambiarIdioma() {
	var idiomaACambiar = "";
	if (idiomaCheck == "EN") {
		idiomaACambiar = "ES"
	} else {
		idiomaACambiar = "EN";	
	}
	checkEmptyFields(idiomaACambiar);
}

var table = $('#tablita').DataTable( {
	dom: 'frtip',
	ajax: "puntoAtraccionNuevoJson/${id}/" + idiomaCheck,
	columns: [
		{	data:"orden",
			render: function (data,type,row) {
		 		return '<span class="ordinal-position">' + data + '</span>'
		 	}
		},
		{	data: "id",
         	render: function (data,type,row) {
		 		return '<div align="center"><img src="${pageContext.request.contextPath}/imagenPunto?id=' + row["idPunto"] 
		 		+ '" style="align: center; width:40px; height:40px"/></div>' 
		 		+ '<span style="display:none" class="clasePuntoId">' + data + '</span>'
		 	}
        },
        {data: "nombre" },
		{defaultContent:'<button class="btn btn-danger" id="borrar">Borrar</button>'},
		{defaultContent:'<button class="btn btn-warning" id="ver">Ver</button>'}
		],
		"columnDefs": [
            {className: "dt-body-center", "targets": [0, 3, 4]}
        ],
		select:true,
		paging:true,
		pageLength:50
});

$('#tablita tbody').on('click', '#borrar', function (e) {
	var data = table.row(this.closest("tr")).data();
	var id = data["id"];
	var mensaje = "¿Desea borrar?";
	e.preventDefault();
	bootbox.confirm(mensaje, function (response) {
		if (response) {
			var formData = new FormData();
			formData.append("id",id);
			formData.append("idAtraccion",0);
			$.ajax({
				url : "borrarPunto",
				type : "POST",
				data : formData,
				enctype: 'multipart/form-data',
				processData : false,
				contentType: false,
				dataType: 'json',
				success: function (data) {
					hideAllAtractionErrorMessages();
					guardarOrden();
					table.ajax.reload();
					closeNewPointOfInterestForm();
				}
			});
		}
	});
});

$('#botonGuardarPuntoDeInteres').on('click', function(e) {
	e.preventDefault();
	validarPunto();	
});

function crearPunto() {
	var formData = new FormData();
	formData.append("imagen",document.getElementById("puntoArchivoImagen").files[0]);
	formData.append("audio",document.getElementById("archivoAudioguiaPdi").files[0]);
	formData.append("nombre",document.getElementById('puntoNombreTextarea').value);//document.formNuevoPuntoDeInteres.puntoNombre.value);
	formData.append("descripcion",document.getElementById('puntoDescripcionTextarea').value);//document.formNuevoPuntoDeInteres.puntoDescripcion.value);
	formData.append("idioma",$("input[name='idioma']:checked").val());
	$.ajax({
		url : "crearPunto",
		type : "POST",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
		success: function (data) {
			if (data.existe == false) {
				alert("HOW");
			} else {
				hideAllAtractionErrorMessages();
				guardarOrden();
				table.ajax.reload();
				closeNewPointOfInterestForm();
			}
		}
	});
}

function validarPuntoDeInteresRepetido() {
	var atraccion = {
		"id": document.formNuevo.id.value
	}
	var json = {
		"atraccion": atraccion,
		"nombre": document.getElementById('puntoNombreTextarea').value//document.formNuevoPuntoDeInteres.puntoNombre.value
	};
	$.ajax({
		url : "validarPuntoDeInteres",
		type : "POST",
		data : JSON.stringify(json),
		processData : false,
		dataType: "json",
		contentType : "application/json",
		success: function (data) {
			if (data.existe == false) {
				crearPunto();
			} else {
				document.getElementById("mensajeNombrePuntoDeInteresRepetido").style.display = 'block';
			}
		}
	});
};

</script>
		
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places,geometry&callback=initMap&language=es" async defer></script>

</body>
</html>
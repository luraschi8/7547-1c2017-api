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
<title>Trips - ${atraccion.atraccion.nombre}</title>
</head>

<body onload="setLanguage();">

	<nav class="navbar navbar-default">
	  	<div class="container-fluid">
		    <ul class="nav navbar-nav">
		      	<li class="active"><a href="ciudades">Ciudades</a></li>
		      	<li><a href="atraccionesDeMayorInteres">Reportes</a></li>
		    </ul>
	  	</div>
	</nav>
	
	<nav class="navbar navbar-default">
		<div class="container-fluid">
	    	<ul class="nav navbar-nav">
	      		<li class="dropdown" id="select_language">
	        		<a class="active dropdown-toggle" data-toggle="dropdown" href="#">Idioma
	        			<span class="caret"></span>
	        		</a>
	        		<ul class="dropdown-menu">
			          	<li onclick="setSpanish();"><a href="#">Espa�ol</a></li>
			          	<li onclick="setEnglish();"><a href="#">Ingl�s</a></li>
	        		</ul>
	      		</li>
	    	</ul>
	  	</div>
	</nav>
    
	<h1 class="page-header atraction-new-page-header" style="margin-left:5rem">${atraccion.atraccion.nombre} - ${atraccion.atraccion.ciudad.nombre}</h1>

<div id="attractionForm">
	<form:form id ="formModificar" name="formModificar" action="atraccionModificar" method="post" commandName="atraccion" enctype="multipart/form-data">
		<form:input type="hidden" id="id" name="id" path="id" value="${atraccion.id}"/>

		<div class="atraction-new-form" style="width: 100%; overflow: hidden;"> 
			
			<!-- Bloque izquierdo (Informaci�n principal, Plano, Galer�a y Audioguia) -->	
			<div style="float:left; margin-top:-0.8rem">
				
				<!-- Informaci�n principal -->
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
					 	<strong>&iexclError!</strong> El nombre no puede estar vac�o. Se ha dejado el �ltimo nombre v�lido.
					</div>
					
					<div>
						<form:label class="atraction-label atraction-description-label" path="descripcion">Descripci�n</form:label>
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
					 	<strong>&iexclError!</strong> La descripci�n no puede estar vac�a. Se ha dejado la �ltima descripci�n v�lida.
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
							  	<input type="radio" id="es-recorrible" name="recorrible" path="recorrible" value="1" style="margin: 4px" onclick="$('#blueprints').show(); $('#view-atraction-points-of-interest-panel').show();">S�
							  	<input type="radio" id="no-es-recorrible" name="recorrible" path="recorrible" value="0" style="margin: 4px; margin-left: 15px;" onclick="$('#blueprints').hide(); $('#view-atraction-points-of-interest-panel').hide();">No
							</div>
						</form>
					</div>
				</div>
			
				<!-- Plano -->
				<div id="blueprints">
					<div>
						<form:label class="atraction-label atraction-blueprints-label" path="atraccion.plano">Plano</form:label>
					</div>
					<div class="atraction-blueprints-box" style="float: left">
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
						 	<strong>&iexclError!</strong> La atracci�n es recorrible. Debe proporcionarse un plano.
						</div>
						<div class="alert alert-danger fade in atraction-alert" id="mensajePlanoIncorrectaError" style="display: none;">
						 	<a class="close" data-dismiss="alert" aria-label="close"></a>
						 	<strong>&iexclError!</strong> El archivo seleccionado no es una imagen. Por favor, introduzca otro.
						</div>
					</div>
				</div>
				
				<!-- Galer�a -->
				<div class="atraction-gallery" style="clear: left">
					<input type="hidden" id="imagenesCambiadas" name="imagenesCambiadas">
					<input type="hidden" id="videoCambiado" name="videoCambiado" value=0>					
					
					<div>
						<form:label class="atraction-label atraction-gallery-label" path="atraccion.listaImagenes">Galer�a</form:label>
					</div>
					<div id="container" class="atraction-gallery-box" style="float:left">
						<img class="atraction-gallery" id="imagenGaleria" style="width:100%; height:100%;">
						<video id="videoGaleria" style="width:100%; height:100%;display:none" controls>
						</video>
						
						<div class="atraction-gallery-buttons">
							<button type="button" class="w3-button w3-display-left atraction-gallery-slide-left" onclick="nextGalleryItem(-1)">&#10094;</button>
							<button type="button" class="w3-button w3-display-right atraction-gallery-slide-right" onclick="nextGalleryItem(+1)">&#10095;</button>
						
							<input type="button" id="atraction-get-gallery-file" class="btn btn-default btn-atraction-get-gallery-file" value="+">
							
							<button type="button" class="btn btn-default btn-sm atraction-erase-multimedia" id="eliminarImagen">
								<span class="glyphicon glyphicon-erase"></span>
							</button>
						</div>
					</div>
				</div>
				
				<div class="alert alert-danger fade in atraction-alert" id="mensajeHayVideo" style="display: none; float:left">
				 	<a class="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>&iexclError!</strong> Ya se ha seleccionado un video anteriormente. S�lo se puede seleccionar uno.
				</div>
				
				<div class="alert alert-danger fade in atraction-alert" id="mensajeCincoArchivos" style="display: none; float:left">
				 	<a class="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>&iexclError!</strong> Ya se han seleccionado 5 archivos, no se pueden agregar m�s.
				</div>
				
				<div class="alert alert-danger fade in atraction-alert" id="mensajeTamanoImagen" style="display: none; float:left">
				 	<a class="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>&iexclError!</strong> La imagen no puede pesar m�s de 50KB.
				</div>
				
				<div class="alert alert-danger fade in atraction-alert" id="mensajeTamanoVideo" style="display: none; float:left">
				 	<a class="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>&iexclError!</strong> El video no puede pesar m�s de 10MB.
				</div>
				
				<div class="alert alert-danger fade in atraction-alert" id="mensajeUnaImagen" style="display: none; float:left">
				 	<a class="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>&iexclError!</strong> Tiene que estar presente una imagen por lo menos!
				</div>
				
				<div class="alert alert-danger fade in atraction-alert" id="mensajeImagenIncorrectaError" style="display: none; float:left">
				 	<a class="close" data-dismiss="alert" aria-label="close"></a>
				 	<strong>&iexclError!</strong> El archivo no es una imagen/video. Por favor, introduzca otra.
				</div>
				
				
				<!-- Audiogu�a -->
				<div style="clear: both">
					<form:label class="atraction-label atraction-audio-label" path="audio">Audiogu�a</form:label>
					<input type="hidden" id="audioCambiado" name="audioCambiado" value=0>
					<div>
						<!-- Reproducir audiogu�a -->
						<div style="float:left">
							<audio id="audio" controls>
							    <source type="audio/mpeg">
							</audio> 
						</div>
						
						<!-- Bot�n agregar audiogu�a -->
						<div style="text-align:center; float:right;">
							<button type="button" class="btn btn-default btn-sm btn-atraction-get-audio-file" id="atraction-get-audio-file">
								<span class="glyphicon glyphicon-pencil"></span>
							</button>
						
							<button type="button" class="btn btn-default btn-sm btn-atraction-erase-audio-file" id="borrarAudio">
								<span class="glyphicon glyphicon-erase"></span>
							</button>
	
							<input type="file" name="archivoAudioguia" id="archivoAudioguia"/>
						</div>
					</div>
				
					<div class="alert alert-danger fade in atraction-alert-incorrect-audio" id="mensajeAudioIncorrectoError" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo seleccionado no es un audio v�lido. Por favor, introduzca otro.
					</div>
					
					<div class="alert alert-danger fade in atraction-alert-incorrect-audio" id="mensajeAudioTamano" style="display: none;">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>Error!</strong> El archivo pesa m�s de 3MB. Por favor, seleccione uno de menor tama�o.
					</div>
				</div>
				
				<div style="clear: both; margin-top: 5rem;">
					<input id="atraction_add_language_btn" class="btn btn-default btn-success" type="button" value="Agregar idioma"/>
				</div>
			</div>
						
			<!-- Bloque derecho (Mapa, Puntos de inter�s y Rese�as) -->
			<div class="atraction-right-block" style="float:right; margin-top: -1rem;">
				<!-- Mapa -->
				<div class="view-atraction-map-group">
					<label>Ubicaci�n</label>
					<div class="atraction-map-div">
						<input id="atraction-map-input" class="atraction-map-controls" type="text" placeholder="Ingresar ubicaci�n">
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
					 	<strong>&iexclError!</strong> No se ha seleccionado una ubicaci�n para la atracci�n.
					</div>
					
					<div class="alert alert-warning fade in atraction-alert-far-location" id="mensajeUbicacionLejana" style="display: none">
					 	<a class="close" data-dismiss="alert" aria-label="close"></a>
					 	<strong>&iexclAdvertencia!</strong> La atracci�n seleccionada est� a m�s de 15km de la ciudad actual.
					</div>
				</div>
				
				<div id="view-atraction-points-of-interest-panel" class="panel panel-primary view-atraction-panel view-atraction-points-of-interest-panel">
					<div style="text-align:center">
						<input id="botonPuntosDeInteres" class="btn btn-ver-puntos-y-obras btn-puntos-de-interes" type="button" value="Puntos de inter�s y obras"/>
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
				 	<strong>&iexclError!</strong> La atracci�n es recorrible. Debe por lo menos un punto de inter�s.
				</div>
				
				<!-- Tabla rese�as (comentarios) -->
				<div class="panel panel-primary view-atraction-panel view-atraction-comments-panel">
					<div style="text-align:center; font-size:110%">
						<p>Rese�as</p>
					</div>
					
					<div class="panel-body atraction-comments">
						<table id="tablaResenias" class="display order-column view-atraction-board" cellspacing="0" width="100%">
							<thead>
								<tr>
						            <th></th> <!-- Rese�a -->
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
		 	<strong>&iexclError!</strong> La atracci�n seleccionada ya se encuentra registrada. Seleccione otra.
		</div>
	</form:form>
</div>

<c:set var="idIdioma">
	${atraccion.id}
</c:set>

<c:set var="editarResenia">
	Editar
</c:set>

<c:set var="borrarResenia">
	Borrar
</c:set>

<c:set var="mensajeBorrarResenia">
 	Se borrar� la rese�a seleccionada. �Desea continuar?
</c:set>

<input id="mensajeBorrarResenia" type="hidden" value="${mensajeBorrarResenia}" />
 
<form id ="formBorrarResenia" name="formBorrarResenia" action="borrarResenia" method="post">
	<input id="idResenia" name="idResenia" type="hidden">
	<input id="idAtraccion" name="idAtraccion" value="${atraccion.id}" type="hidden"> 
</form>

<c:set var="latitud_atraccion">
	${atraccion.atraccion.latitud}
</c:set>

<c:set var="longitud_atraccion">
	${atraccion.atraccion.longitud}
</c:set>

<c:set var="latitud_ciudad">
	${atraccion.atraccion.ciudad.latitud}
</c:set>

<c:set var="longitud_ciudad">
	${atraccion.atraccion.ciudad.longitud}
</c:set>

<c:set var="id">
	${atraccion.atraccion.id}
</c:set>

<c:set var="idioma">
	${idioma}
</c:set>

    
<script>
var comments_table = $('#tablaResenias').DataTable({
	dom: 'frtip',
	ajax: "reseniasAtraccionJson/${id}",
    columns: [
        {	data: "id",
            render: function (data,type,row) {
            	return "Enviado por " + row.nombreUsuario + "<br>" + row.fecha + " a las " + row.hora + "<br>" + row.calificacion + "<br>" + row.comentario;
        	}
        },
        {defaultContent:'<button class="btn btn-danger" id="borrarResenia">${borrarResenia}</button>'},
        {defaultContent:'<button class="btn btn-warning" id="editarResenia">${editarResenia}</button>'}
        ],
    "columnDefs": [
   		{className: "dt-body-center", "targets": [1, 2]}
    ],
    select:true,
    paging:false,
    pageLength:10,
    ordering:true,
    bFilter: false
});

$('#tablaResenias tbody').on('click', '#borrarResenia', function (e) {
	 	var data = comments_table.row(this.closest("tr")).data();
	 	var id = data["id"];
	 	var mensaje = "�Desea borrar la rese�a seleccionada?";
	 	e.preventDefault();
	 	bootbox.confirm(mensaje, function (response) {
	 		if (response) {
	 			var formData = new FormData();
	 			formData.append("id", id);
	 			$.ajax({
	 				url : "borrarResenia",
	 				type : "POST",
	 				data : formData,
	 				enctype: 'multipart/form-data',
	 				processData : false,
	 				contentType: false,
	 				dataType: 'json',
	 				success: function (data) {
	 					hideAllAtractionErrorMessages();
	 					comments_table.ajax.reload();
	 				}
	 			});
	 		}
	 	});
});

function openEditComment() {
	hideAllAtractionErrorMessages();
	document.getElementById('atraction-comment-popup').style.display = 'block';
	document.getElementById('atraction-comment-popup').focus();
	document.getElementById('attractionForm').blur();
	disableAtractionPage();
}

function closeEditComment() {
	hideAllAtractionErrorMessages();
	document.getElementById('atraction-comment-popup').style.display = 'none';
	document.getElementById('atraction-comment-popup').blur();
	document.getElementById('attractionForm').focus();
	enableAtractionPage();
}

function saveCommentsEdition() {
	var formData = new FormData();
	formData.append("idResenia", document.getElementById('atraction-comment-id').innerHTML);
	formData.append("comentario", document.getElementById('atraction-comment').value);
	$.ajax({
		url : "editarResenia",
		type : "POST",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
		success: function (data) {
			hideAllAtractionErrorMessages();
			comments_table.ajax.reload();
		}
	});
	closeEditComment();
}

$('#tablaResenias tbody').on('click', '#editarResenia', function (e) {
	e.preventDefault();
	openEditComment();
	var data = comments_table.row(this.closest("tr")).data();
	
	document.getElementById('atraction_edit_comment_date_and_user').innerHTML = "Enviado el " + data['fecha'] + " a las " + data['hora'] + " por " + data['nombreUsuario'] + ".";
	document.getElementById('atraction_edit_comment_qualification').innerHTML = "Calificaci�n: " + data['calificacion'];
	document.getElementById('atraction-comment').value = data['comentario'];
	document.getElementById('atraction-comment-id').innerHTML = data['id'];
});
</script>

	
<div id="atraction-point-of-interest-popup-form" style="width: 50%; height: 100%">
	<div style="margin-left: 5%; margin-right: 5%; width: 90%; height: 90%">
		<form:form class="atraction-new-point-of-interest" style="width: 100%; height: 100%" id="formNuevoPuntoDeInteres" name="formNuevoPuntoDeInteres" action="nuevoPuntoDeInteres" method="post" commandName="puntoDeInteres" enctype="multipart/form-data">
			<h2 style="width: 100%; height: 8%" class="new_point_of_interest_header puntoCreacion">Nuevo punto de inter�s</h2>
			<h2 style="width: 100%; height: 8%; display: none;" class="view_point_of_interest_header puntoEdicion">Ver punto de inter�s</h2>
			
			<p style="display: none;" id="idPunto" name="idPunto"></p> 
			
			<div style="width: 100%; height: 11%">
				<div style="display: inline-block;">
					<label class="atraction-label" path="nombre">Nombre</label><font color="red" class="puntoCreacionInline">&nbsp;*</font>
				</div>
				<button style="display: none" type="button" class="btn btn-default btn-sm puntoEdicionInline" id="puntoEditNameButton" onclick="editField('#puntoNombre', 'ok-nombre-punto', 'cancel-nombre-punto', 'mensajeNombreVacioPuntoDeInteresError', true);">
					<span class="glyphicon glyphicon-pencil"></span>
				</button>
				<button type="button" class="btn btn-default btn-sm" style="display:none; background-color: red;" id="cancel-nombre-punto" onclick="cancelField('#puntoNombre', 'ok-nombre-punto', 'cancel-nombre-punto')">
					<span class="glyphicon glyphicon-remove"></span>
				</button>
				<button type="button" class="btn btn-default btn-sm" style="display:none; background-color: green;" id="ok-nombre-punto" onclick="saveField('#puntoNombre', 'ok-nombre-punto', 'cancel-nombre-punto', 'mensajeNombreVacioPuntoDeInteresError', true)">
					<span class="glyphicon glyphicon-ok"></span>
				</button>
				<div>
					<textarea onkeydown="calculateMaxLength('#puntoNombreTextarea', MAX_NOMBRE_PUNTO_DE_INTERES)" rows="1" id="puntoNombreTextarea" path="nombre" name="puntoNombreTextarea" class="atraction-poi-box puntoCreacion"  placeholder="Ingrese el nombre del punto de inter�s" required="required"/></textarea>
				</div>
				<div>
					<p style="display: none;" id="puntoNombre" name="puntoNombre" class="atraction-poi-box puntoEdicion"/></p>
				</div>
			</div>
			<div class="alert alert-danger fade in atraction-poi-alert" id="mensajeNombreVacioPuntoDeInteresError" style="display: none; margin-top: 2%;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> El nombre no puede estar vac�o.
			</div>
			
			<div style="width: 100%; height: 15%;">
				<div style="display: inline-block;">
					<label class="atraction-label" path="descripcion">Descripci�n</label><font color="red" class="puntoCreacionInline">&nbsp;*</font>
				</div>
				
				<button style="display: none" type="button" class="btn btn-default btn-sm puntoEdicionInline" id="puntoEditDescriptionButton" onclick="editField('#puntoDescripcion', 'ok-descripcion-punto', 'cancel-descripcion-punto', 'mensajeDescripcionVaciaPuntoDeInteresError', true);">
					<span class="glyphicon glyphicon-pencil"></span>
				</button>
				<button type="button" class="btn btn-default btn-sm" style="display:none; background-color: red;" id="cancel-descripcion-punto" onclick="cancelField('#puntoDescripcion', 'ok-descripcion-punto', 'cancel-descripcion-punto')">
					<span class="glyphicon glyphicon-remove"></span>
				</button>
				<button type="button" class="btn btn-default btn-sm" style="display:none; background-color: green;" id="ok-descripcion-punto" onclick="saveField('#puntoDescripcion', 'ok-descripcion-punto', 'cancel-descripcion-punto', 'mensajeNombreVacioPuntoDeInteresError', true)">
					<span class="glyphicon glyphicon-ok"></span>
				</button>
				
				<div>
					<textarea onkeydown="calculateMaxLength('#puntoDescripcionTextarea', MAX_DESCRIPCION_PUNTO_DE_INTERES)" id="puntoDescripcionTextarea" path="descripcion" name="puntoDescripcionTextarea" class="atraction-poi-box puntoCreacion"  placeholder="Ingrese la descripci�n del punto de inter�s" required="required"/></textarea>
				</div>
				<div>
					<p id="puntoDescripcion" name="puntoDescripcion" class="atraction-poi-box puntoEdicion"/></p>
				</div>
			</div>
			<div class="alert alert-danger fade in atraction-poi-alert" id="mensajeDescripcionVaciaPuntoDeInteresError" style="display: none; margin-top: 2%;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> La descripci�n no puede estar vac�a.
			</div>
			
			<div style="width: 100%; height: 33%;">
				<div style="width: 100%; height: 18%">
					<label class="atraction-label" path="imagen">Imagen</label><font color="red" class="puntoCreacionInline">&nbsp;*</font>
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
					<label class="atraction-label" path="audioES">Audiogu�a</label>
				</div>
				<input type="hidden" id="audioCambiadoPdi" name="audioCambiadoPdi" value=0>
				<div style="width: 100%; height: 60%">
					<!-- Reproducir audiogu�a -->
					<div style="float: left; width: 85%; height: 50%">
						<audio id="puntoAudio" style="width: 100%;" controls>
						    <source type="audio/mpeg">
						</audio> 
					</div>
					
					<!-- Bot�n agregar audiogu�a -->
					<div style="float: right; width: 15%; height: 50%; text-align: right;">
						<button type="button" class="btn btn-default btn-sm" id="puntoGetAudio">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
					
						<button type="button" class="btn btn-default btn-sm" id="borrarAudioPdi">
							<span class="glyphicon glyphicon-erase"></span>
						</button>
	
						<input type="file" name="archivoAudioguiaPdi" id="archivoAudioguiaPdi"/>
					</div>
				</div>
			</div>
			
			<div class="alert alert-danger fade in atraction-poi-alert" id="mensajeAudioPdiIncorrectoError" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El archivo seleccionado no es un audio v�lido. Por favor, introduzca otro.
			</div>
			
			<div class="alert alert-danger fade in atraction-poi-alert" id="mensajeAudioPdiTamano" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El archivo pesa m�s de 3MB. Por favor, seleccione uno de menor tama�o.
			</div>
			
			<div class="alert alert-danger fade in" id="mensajeNombrePuntoDeInteresRepetido" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El nombre del punto de inter�s ingresado ya se encuentra registrado. Por favor, ingrese otro.
			</div>
			<font style="margin-left: 1%;" color="red" size="1">Los campos indicados con * son obligatorios</font>
			
			<div style="clear: both; margin-top: 3%">
				<input id="point_of_interest_add_language_btn" class="btn btn-default btn-success puntoEdicion" type="button" value="Agregar idioma"/>
			</div>
			
			<div class="btn-final-pdi-form" style="width: 100%; text-align:center; clear:both;">
				<input id="botonCancelarPuntoDeInteres" class="btn btn-default" type="button" value="Cancelar" onclick="closeNewPointOfInterestForm();"/>
				<input id="botonGuardarPuntoDeInteres" class="btn btn-default btn-primary puntoCreacionInline" type="button" value="Guardar"/>
				<input id="botonGuardarEdicionPuntoDeInteres" style="display: none" class="btn btn-default btn-primary puntoEdicionInline" type="button" value="Guardareee"/>
			</div>
		</form:form>
	</div>
</div>
<form:form id="formGuardarPuntoDeInteres" action="atraccionVer?idAtraccion=${atraccion.id}" method="post"></form:form>

<div id="atraction-comment-popup">
	<div class="atraction-view-comment" id ="atraction-view-comment" name="atraction-view-comment">
		<h2>Edici�n rese�a</h2>
		
		<div class="atraction-comment-group">
			<div style="float: center;">
			 	<div>
			 		<p style="display: none" id="atraction-comment-id"></p>
					<p id="atraction_edit_comment_date_and_user"></p>
					<p id="atraction_edit_comment_qualification"></p>
					<textarea onkeydown="calculateMaxLength('#atraction-comment', MAX_COMENTARIO)" id="atraction-comment" name="atraction-comment" class="atraction-box" required="required" rows="5"></textarea>
				</div>
			</div>
		</div>
	</div>
	
	<div class="btn-final-edicion-comentario-popup" style="text-align:center; clear: right;">
		<input id="botonCancelarComentario" class="btn btn-default" type="button" value="Cancelar" onclick="closeViewCommentPopUp();"/>
		<input id="botonGuardarComentario" class="btn btn-default btn-primary" type="button" value="Guardar" onclick="saveCommentsEdition();"/>
	</div>
</div>

<form:form id="formAtras" name="formAtras" action="ciudadVer?idCiudad=${atraccion.atraccion.ciudad.id}" method="post">
	<input id="ordenOriginal" name="ordenOriginal" type="hidden" value="">
</form:form>
<div class="btn-final" style="text-align:center;">
	<input id="botonAtras" class="btn btn-default" type="button" value="Atr�s"/> 
	<input id="botonNuevo" class="btn btn-default btn-primary" type="button" value="Aceptar"/>
</div>


<div id="atraction_new_language_popup" style="display: none; width: 50%; height: 100%">
	<div style="margin-left: 5%; margin-right: 5%; width: 90%; height: 90%">
		<form:form class="atraction-new-language" style="width: 100%; height: 100%" id="formAtraccionNuevoLenguaje" name="formAtraccionNuevoLenguaje" action="nuevoLenguajeAtraccion" method="post" commandName="atraccion" enctype="multipart/form-data">
			<h2 style="width: 100%; height: 8%">A�adir lenguaje</h2>
			
			<div style="width: 100%; height: 20%">
				<div style="display: inline-block;">
					<label class="atraction-label" path="descripcion">Descripci�n</label><font color="red"> *</font>
				</div>
				
				<div>
					<textarea onkeydown="calculateMaxLength('#atraccionDescripcionNuevoLenguaje', MAX_DESCRIPCION_ATRACCION)" id="atraccionDescripcionNuevoLenguaje" path="descripcion" name="atraccionDescripcionNuevoLenguaje" class="atraccion_nuevo_lenguaje_box"  placeholder="Ingrese la descripci�n de la atracci�n" required="required"/></textarea>
				</div>
			</div>
			<div class="alert alert-danger fade in atraction_new_language_alert" id="mensajeDescripcionVaciaAtraccionNuevoLenguajeError" style="display: none; margin-top: 2%;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> La descripci�n no puede estar vac�a.
			</div>
			
			<div style="width: 100%; height: 20%">
				<div style="display: inline-block;">
					<label class="atraction-label" path="horario">Horario</label>
				</div>
				
				<div>
					<textarea onkeydown="calculateMaxLength('#atraccionHorarioNuevoLenguaje', MAX_HORARIO_ATRACCION)" id="atraccionHorarioNuevoLenguaje" path="horario" name="atraccionHorarioNuevoLenguaje" class="atraccion_nuevo_lenguaje_box"  placeholder="Ingrese el horario de la atracci�n" required="required"/></textarea>
				</div>
			</div>
			
			<div style="width: 100%; height: 20%">
				<div style="display: inline-block;">
					<label class="atraction-label" path="precio">Precio</label>
				</div>
				
				<div>
					<textarea onkeydown="calculateMaxLength('#atraccionPrecioNuevoLenguaje', MAX_PRECIO_ATRACCION)" id="atraccionPrecioNuevoLenguaje" path="precio" name="atraccionPrecioNuevoLenguaje" class="atraccion_nuevo_lenguaje_box"  placeholder="Ingrese el precio de la atracci�n" required="required"/></textarea>
				</div>
			</div>

			<div style="width: 100%; height: 14%">
				<div style="width: 100%; height: 40%">
					<label class="atraction-label" path="audio">Audiogu�a</label>
				</div>
				<input type="hidden" id="audioCambiadoAtraccionNuevoLenguaje" name="audioCambiadoAtraccionNuevoLenguaje" value=0>
				<div style="width: 100%; height: 60%">
					<!-- Reproducir audiogu�a -->
					<div style="float: left; width: 85%; height: 50%">
						<audio id="audioAtraccionNuevoLenguaje" style="width: 100%;" controls>
						    <source type="audio/mpeg">
						</audio> 
					</div>
					
					<!-- Bot�n agregar audiogu�a -->
					<div style="float: right; width: 15%; height: 50%; text-align: right;">
						<button type="button" class="btn btn-default btn-sm" id="getAudioAtraccionNuevoLenguaje">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
					
						<button type="button" class="btn btn-default btn-sm" id="borrarAudioAtraccionNuevoLenguaje">
							<span class="glyphicon glyphicon-erase"></span>
						</button>
	
						<input type="file" name="archivoAudioguiaAtraccionNuevoLenguaje" id="archivoAudioguiaAtraccionNuevoLenguaje"/>
					</div>
				</div>
			</div>
			
			<div class="alert alert-danger fade in atraction_new_language_alert" id="mensajeAudioAtraccionNuevoLenguajeIncorrectoError" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El archivo seleccionado no es un audio v�lido. Por favor, introduzca otro.
			</div>
			
			<div class="alert alert-danger fade in atraction_new_language_alert" id="mensajeAudioAtraccionNuevoLenguajeTamano" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El archivo pesa m�s de 3MB. Por favor, seleccione uno de menor tama�o.
			</div>

			<font style="margin-left: 1%;" color="red" size="1">Los campos indicados con * son obligatorios</font>
			
			<div class="btn_final_atraction_new_language_popup" style="width: 100%; text-align:center; clear:both; margin-top: 3%;">
				<input id="botonCancelarAtraccionNuevoLenguaje" class="btn btn-default" type="button" value="Cancelar" onclick="closeAtractionNewLanguagePopup();"/>
				<input id="botonGuardarAtraccionNuevoLenguaje" class="btn btn-default btn-primary" type="button" value="Guardar" onclick="guardarAtraccionNuevoLenguaje();"/>
			</div>
		</form:form>
	</div>
</div>


<div id="point_of_interest_new_language_popup" style="display: none; width: 50%; height: 60%">
	<div style="margin-left: 5%; margin-right: 5%; width: 90%; height: 90%">
		<form:form class="atraction-point-of-interest-new-language" style="width: 100%; height: 100%" id="formPuntoNuevoLenguaje" name="formPuntoNuevoLenguaje" action="nuevoLenguajePunto" method="post" commandName="atraccion" enctype="multipart/form-data">
			<h2 style="width: 100%; height: 12%">A�adir lenguaje</h2>
			
			<div style="width: 100%; height: 35%">
				<div style="display: inline-block;">
					<label class="atraction-label" path="descripcion">Descripci�n</label><font color="red"> *</font>
				</div>
				
				<div>
					<textarea onkeydown="calculateMaxLength('#puntoDescripcionNuevoLenguajeTextarea', MAX_DESCRIPCION_PUNTO_DE_INTERES)" id="puntoDescripcionNuevoLenguajeTextarea" path="descripcion" name="puntoDescripcionNuevoLenguajeTextarea" class="punto_nuevo_lenguaje_box"  placeholder="Ingrese la descripci�n del punto de inter�s" required="required"/></textarea>
				</div>
			</div>
			<div class="alert alert-danger fade in point_of_interest_new_language_alert" id="mensajeDescripcionVaciaPuntoDeInteresNuevoLenguajeError" style="display: none; margin-top: 2%;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>&iexclError!</strong> La descripci�n no puede estar vac�a.
			</div>

			<div style="width: 100%; height: 28%">
				<div style="width: 100%; height: 40%">
					<label class="atraction-label" path="audio">Audiogu�a</label>
				</div>
				<input type="hidden" id="audioCambiadoPuntoDeInteresNuevoLenguaje" name="audioCambiadoPuntoDeInteresNuevoLenguaje" value=0>
				<div style="width: 100%; height: 60%">
					<!-- Reproducir audiogu�a -->
					<div style="float: left; width: 85%; height: 50%">
						<audio id="audioPuntoDeInteresNuevoLenguaje" style="width: 100%;" controls>
						    <source type="audio/mpeg">
						</audio> 
					</div>
					
					<!-- Bot�n agregar audiogu�a -->
					<div style="float: right; width: 15%; height: 50%; text-align: right;">
						<button type="button" class="btn btn-default btn-sm" id="getAudioPuntoDeInteresNuevoLenguaje">
							<span class="glyphicon glyphicon-pencil"></span>
						</button>
					
						<button type="button" class="btn btn-default btn-sm" id="borrarAudioPuntoDeInteresNuevoLenguaje">
							<span class="glyphicon glyphicon-erase"></span>
						</button>
	
						<input type="file" name="archivoAudioguiaPuntoDeInteresNuevoLenguaje" id="archivoAudioguiaPuntoDeInteresNuevoLenguaje"/>
					</div>
				</div>
			</div>
			
			<div class="alert alert-danger fade in point_of_interest_new_language_alert" id="mensajeAudioPuntoDeInteresNuevoLenguajeIncorrectoError" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El archivo seleccionado no es un audio v�lido. Por favor, introduzca otro.
			</div>
			
			<div class="alert alert-danger fade in point_of_interest_new_language_alert" id="mensajeAudioPuntoDeInteresNuevoLenguajeTamano" style="display: none;">
			 	<a class="close" data-dismiss="alert" aria-label="close"></a>
			 	<strong>Error!</strong> El archivo pesa m�s de 3MB. Por favor, seleccione uno de menor tama�o.
			</div>

			<font style="margin-left: 1%;" color="red" size="1">Los campos indicados con * son obligatorios</font>
			
			<div class="btn_final_point_of_interest_new_language_popup" style="width: 100%; text-align:center; clear:both; margin-top: 3%; margin-bottom: 3%;">
				<input id="botonCancelarPuntoNuevoLenguaje" class="btn btn-default" type="button" value="Cancelar" onclick="closePointOfInterestNewLanguagePopup();"/>
				<input id="botonGuardarPuntoNuevoLenguaje" class="btn btn-default btn-primary" type="button" value="Guardar" onclick="guardarPuntoNuevoLenguaje();"/>
			</div>
		</form:form>
	</div>
</div>

<form:form id="formVer" name="formVer" action="atraccionVer" method="get">
	<input id="idAtraccion" name="idAtraccion" type="hidden" value="${atraccion.atraccion.id}"/>
	<input id="idioma" name="idioma" type="hidden" value="${idioma}"/>
</form:form>

<script src="${pageContext.request.contextPath}/js/puntoInteres.js"></script>

<script>
$('#atraction_add_language_btn').on('click', function(e) {
	e.preventDefault();
	showAtractionNewLanguagePopup();
});

$('#point_of_interest_add_language_btn').on('click', function(e) {
	e.preventDefault();
	showPointOfInterestNewLanguagePopup();
});

function setSpanish() {
	document.formVer.idioma.value = "ES";
	document.getElementById("formVer").submit();
}

function setEnglish() {
	document.formVer.idioma.value = "EN";
	document.getElementById("formVer").submit();
}

function setLanguage() {
	if ("${idioma}" == "ES") {
		document.getElementById("select_language").innerHTML = "<a class='active dropdown-toggle' data-toggle='dropdown' href='#'>Espa&ntilde;ol<span class='caret'></span></a><ul class='dropdown-menu'><li onclick='setSpanish();'><a href='#'>Espa�ol</a></li><li onclick='setEnglish();'><a href='#'>Ingl�s</a></li></ul></li>";
	} else {
		document.getElementById("select_language").innerHTML = "<a class='active dropdown-toggle' data-toggle='dropdown' href='#'>Ingl&eacute;s<span class='caret'></span></a><ul class='dropdown-menu'><li onclick='setSpanish();'><a href='#'>Espa�ol</a></li><li onclick='setEnglish();'><a href='#'>Ingl�s</a></li></ul></li>";
	}
}

function hideAllPointsOfInterestNewLanguageErrorMessages() {
	document.getElementById('mensajeDescripcionVaciaPuntoDeInteresNuevoLenguajeError').style.display = 'none';
	document.getElementById('mensajeAudioPuntoDeInteresNuevoLenguajeIncorrectoError').style.display = 'none';
	document.getElementById('mensajeAudioPuntoDeInteresNuevoLenguajeTamano').style.display = 'none';
}

function showPointOfInterestNewLanguagePopup() {
	document.getElementById("point_of_interest_new_language_popup").style.display = 'block';
	document.getElementById('point_of_interest_new_language_popup').focus();
	document.getElementById('atraction-point-of-interest-popup-form').style.display = 'none';
	document.getElementById('attractionForm').blur();
	disableAtractionPage();
}

function closePointOfInterestNewLanguagePopup() {
	document.getElementById('point_of_interest_new_language_popup').style.display = 'none';
	document.getElementById('puntoDescripcionNuevoLenguajeTextarea').value = '';
	document.getElementById('audioPuntoDeInteresNuevoLenguaje').src = '';
	hideAllPointsOfInterestNewLanguageErrorMessages();
	document.getElementById('atraction-point-of-interest-popup-form').style.display = 'block';
}

</script>


<!-- Definici�n de constantes -->
<script>
const MAX_NOMBRE_ATRACCION = "50";
const MAX_DESCRIPCION_ATRACCION = "250";
const MAX_HORARIO_ATRACCION = "100";
const MAX_PRECIO_ATRACCION = "100";
$("#nombreEditadoTextarea").attr("maxlength", MAX_NOMBRE_ATRACCION);
$("#descripcionEditadaTextarea").attr("maxlength", MAX_DESCRIPCION_ATRACCION);
$("#horarioEditadoTextarea").attr("maxlength", MAX_HORARIO_ATRACCION);
$("#precioEditadoTextarea").attr("maxlength", MAX_PRECIO_ATRACCION);

const MAX_COMENTARIO = "500";
$("atraction-comment").attr("maxlength", MAX_COMENTARIO);

if (${atraccion.atraccion.recorrible}) {
	$("#es-recorrible").attr("checked", "checked");
	$("#blueprints").show();
	$("#view-atraction-points-of-interest-panel").show();
} else {
	$("#no-es-recorrible").attr("checked", "checked");
	$("#blueprints").hide();
	$("#view-atraction-points-of-interest-panel").hide();
}
</script>

<script>
function validarElemento(elemento, mensaje, hayError) {
	if ((document.getElementById(elemento).value == '') && (!hayError)) {
		document.getElementById(mensaje).style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById(mensaje).style.display = 'none';
	}
	return hayError;
}
	
$(document).ready(function() {
	checkAtraccionNuevoLenguaje();
	validateAudio("getAudioPuntoDeInteresNuevoLenguaje", "borrarAudioPuntoDeInteresNuevoLenguaje", "archivoAudioguiaPuntoDeInteresNuevoLenguaje", "audioPuntoDeInteresNuevoLenguaje", "audioCambiadoPuntoDeInteresNuevoLenguaje", "mensajeAudioPuntoDeInteresNuevoLenguajeTamano", "mensajeAudioPuntoDeInteresNuevoLenguajeIncorrectoError");
	far_away = false;
	
	function updateForm() {
		document.formModificar.nombre.value = $('#nombreEditado').html();
		document.formModificar.descripcion.value = $('#descripcionEditada').html();
		document.formModificar.horario.value = $('#horarioEditado').html();
		document.formModificar.precio.value = $('#precioEditado').html();
		document.formModificar.recorrible.value = $("input[name='recorrible']:checked").val();
	}
	
	$('#botonAtras').on('click', function(e) {
		e.preventDefault();
		document.formAtras.ordenOriginal.value = ordenOriginal;
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
			if (!hayError) {
				//hayError = validarPlano('plano', 'mensajePuntoDeInteresNecesario', hayError);
			} else {
				document.getElementById("mensajePuntoDeInteresNecesario").style.display = 'none';
			}
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
			"id": document.formModificar.idCiudad.value,
		}
		var a = {
			"ciudad": ciudad,
			"id": "${id}",
			"nombre": document.formModificar.nombre.value
		}
		
		var json = {
			"atraccion": a
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
				    	    message: "La atracci�n se encuentra a m�s de 15km de distancia de la ciudad. �Desea guardar los cambios de todos modos?",
				    	    buttons: {
				    	        confirm: {
				    	            label: 'S�'
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
});
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
		document.getElementById('plano').src = "${pageContext.request.contextPath}/planoAtraccion?id=${atraccion.atraccion.id}";
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
				document.getElementById("mensajePlanoIncorrectaError").style.display = 'block';
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

$(document).ready(function() {
	document.getElementById('puntoGetImagen').onclick = function() {
		hideAllAtractionErrorMessages();
		document.getElementById('puntoArchivoImagen').addEventListener('change', readURL, true);
		document.getElementById('puntoArchivoImagen').src = "//:0";
		var fileButton = document.getElementById('puntoArchivoImagen');
		fileButton.click();
	};

	$("#puntoArchivoImagen").change(function() {
	    var val = $(this).val();
	    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
	        case 'gif': case 'jpg': case 'png': case 'jpeg': case 'bmp': 
	        	document.getElementById("mensajeImagenIncorrectaError").style.display = 'none';
	        	break;
	        default:
	            $(this).val('');
				document.getElementById("mensajeImagenVaciaPuntoDeInteresError").style.display = 'block';
				document.getElementById('puntoArchivoImagen').src = "";
				document.getElementById('puntoImagen').src = "";
				break;
	    }
	});
	
	function readURL() {
		document.getElementById("puntoImagenCambiada").value = "1";
		var file = document.getElementById("puntoArchivoImagen").files[0];
		var reader = new FileReader();
	    reader.onloadend = function() {
			document.getElementById('puntoImagen').src = reader.result ;        
			}
		if(file) {
			reader.readAsDataURL(file);
		} 
	}
});
</script>


<!-- Gallery -->
<script>

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

/*--------Galer�a-----------*/

$(document).ready(function() {
	<c:forEach items="${atraccion.atraccion.listaImagenes}" var="imagenAtraccion">
	    var imAt = new Object();
	    imAt.src = "${pageContext.request.contextPath}/imagenAtraccion?id=" + '${imagenAtraccion.id}';
	    imAt.imagen = 1;
	    imAt.idImagen = ${imagenAtraccion.id};
	    multimedia.push(imAt);
	    imageNumber += 1;
	</c:forEach>

	<c:if test="${atraccion.atraccion.video != null}">
		var imAt = new Object();
	    imAt.src = "${pageContext.request.contextPath}/videoAtraccion?id=" + '${atraccion.atraccion.id}';
	    imAt.imagen = 0;
	    multimedia.push(imAt);
		videoNumber = 1;
		video = document.getElementById('videoGaleria');
		var source = document.createElement('source');
	    source.src = "${pageContext.request.contextPath}/videoAtraccion?id=" + '${atraccion.atraccion.id}';
	    source.type = "video/mp4";
		video.appendChild(source);
	</c:if>
	
	<c:if test="${atraccion.audio != null}">
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
	        case 'mp4': case 'webm': case 'm4v':
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
	        		if (ext == 'webm') {
	        			videoType='video/webm';
	        		} else {
	        			videoType='video/m4v';
		        	}
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


<!-- Audiogu�a -->
<script>   
$(document).ready(function() {
	validateAudio("atraction-get-audio-file", "borrarAudio", "archivoAudioguia", "audio", "audioCambiado", "mensajeAudioTamano", "mensajeAudioIncorrectoError");
	validateAudio("getAudioAtraccionNuevoLenguaje", "borrarAudioAtraccionNuevoLenguaje", "archivoAudioguiaAtraccionNuevoLenguaje", "audioAtraccionNuevoLenguaje", "audioCambiadoAtraccionNuevoLenguaje", "mensajeAudioAtraccionNuevoLenguajeTamano", "mensajeAudioAtraccionNuevoLenguajeIncorrectoError");
});
</script>




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
	if (hubo_click) {
		map_lat = aux_lat;
		map_lng = aux_lng;
	}
	setPosition(map_lat, map_lng);
	if (out_of_range) {
		far_away = true;
	}
	google.maps.event.clearInstanceListeners(map);
	google.maps.event.clearInstanceListeners(autocomplete);
	hideOkAndCancelButtonsForCoordinates();
	hideAllAtractionErrorMessages();
}

function cancelEditingCoordinates() {
	google.maps.event.clearInstanceListeners(map);
	google.maps.event.clearInstanceListeners(autocomplete);
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




	    out_of_range = isOutOfRange(place.geometry.location);



	    
	
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
	
	// Al clickear en el mapa, se guardan las coordenadas y se dibuja la ubicaci�n
	google.maps.event.addListener(map, 'click', function(event) {
		marker.setVisible(false);
		marker.setPosition(event.latLng);
	    marker.setVisible(true);

		// Se guardan las coordenadas
		aux_lat = event.latLng.lat();
		aux_lng = event.latLng.lng();
	   	
	   	out_of_range = isOutOfRange(event.latLng);
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
   	
   	google.maps.event.addDomListener(input, 'keydown', function(e) { 
		if (e.keyCode == 13) { 
			e.preventDefault(); 
		}
	});
   	
   	infowindow = new google.maps.InfoWindow();
   	marker = new google.maps.Marker({
   	    map: map
   	});

    marker.setPosition(map.center);
   	marker.setVisible(true);
}

function isOutOfRange(coordinates) {
	// Se verifica si la ubicaci�n seleccionada se encuentra a m�s de 15km.
	var out_of_range;
   	var city_coordinates = new google.maps.LatLng(${latitud_ciudad}, ${longitud_ciudad});
	if (google.maps.geometry.spherical.computeDistanceBetween(coordinates, city_coordinates) < 15000) {
		document.getElementById("mensajeUbicacionLejana").style.display = 'none';
		out_of_range = false;
    } else {
    	document.getElementById("mensajeUbicacionLejana").style.display = 'block';
    	out_of_range = true;
    }
    hubo_click = true;
    return out_of_range;
}


/* PUNTO DE INTERES  */
var table = $('#tablita').DataTable( {
	dom: 'frtip',
	ajax: "puntoAtraccionNuevoJson/${id}/${idioma}",
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

ordenOriginal = '';
<c:if test="${listaPuntos != null}">
	<c:forEach items="${listaPuntos}" var="punto">
	    <c:if test="${punto.borrado == 0}">
	    	ordenOriginal += ${punto.id} + ";";
	    </c:if>
	</c:forEach>
</c:if>

$('#tablita tbody').on('click', '#borrar', function (e) {
	var data = table.row(this.closest("tr")).data();
	var id = data["id"];
	var mensaje = "�Desea borrar?";
	e.preventDefault();
	bootbox.confirm(mensaje, function (response) {
		if (response) {
			var formData = new FormData();
			formData.append("id",id);
			formData.append("idAtraccion",${idIdioma});
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

$('#tablita tbody').on('click', '#ver', function (e) {
	e.preventDefault();
	openNewPointOfInterestForm();
	var data = table.row(this.closest("tr")).data();
	document.getElementById("puntoNombre").innerHTML = data["nombre"];
	document.getElementById("puntoDescripcion").innerHTML = data["descripcion"];
	document.getElementById("idPunto").value = data["idPunto"];
	document.getElementById('puntoImagen').src = "${pageContext.request.contextPath}/imagenPunto?id=" + data["idPunto"];
	document.getElementById('puntoAudio').src = "${pageContext.request.contextPath}/audioPunto?id=" + data["id"];
	showEditionElements();
});

$('#botonGuardarPuntoDeInteres').on('click', function(e) {
	e.preventDefault();
	validarPunto();
});

function updateEdicionPunto() {
	document.getElementById("puntoNombreTextarea").value = $('#puntoNombre').html();
	document.getElementById("puntoDescripcionTextarea").value = $('#puntoDescripcion').html();
}

$('#botonGuardarEdicionPuntoDeInteres').on('click', function(e) {
	e.preventDefault();
	updateEdicionPunto();
	validarEdicionPunto();
	
	var formData = new FormData();
	formData.append("id", table.row(this.closest("tr")).data()["id"]);
	formData.append("nombre", document.getElementById("puntoNombreTextarea").value);
	formData.append("descripcion", document.getElementById("puntoDescripcionTextarea").value);
	formData.append("imagenCambiada", document.getElementById("puntoImagenCambiada").value);
	formData.append("imagen", document.getElementById("puntoArchivoImagen").files[0]);
	formData.append("audioCambiado", document.getElementById("audioCambiadoPdi").value);
	formData.append("audio", document.getElementById("archivoAudioguiaPdi").files[0]);
	$.ajax({
		url : "modificarPunto",
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
				table.ajax.reload();
				closeNewPointOfInterestForm();
			}
		}
	});
});

function crearPunto() {
	var formData = new FormData();
	formData.append("imagen",document.getElementById("puntoArchivoImagen").files[0]);
	formData.append("audio",document.getElementById("archivoAudioguiaPdi").files[0]);
	formData.append("nombre",document.formNuevoPuntoDeInteres.puntoNombreTextarea.value);
	formData.append("descripcion",document.formNuevoPuntoDeInteres.puntoDescripcionTextarea.value);
	formData.append("idAtraccion","${id}");
	formData.append("idioma","${idioma}");
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
		"id": document.formModificar.id.value
	}
	var json = {
		"atraccion": atraccion,
		"nombre": document.formNuevoPuntoDeInteres.puntoNombreTextarea.value
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




/****************************
Agregar Idioma
*****************************/

function checkAtraccionNuevoLenguaje() {
	var formData = new FormData();
	formData.append("id", "${id}");
	$.ajax({
		url : "checkAgregarLenguajeAtraccion",
		type : "POST",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
		success: function (data) {
			if (data == true) {
				document.getElementById('atraction_add_language_btn').style.display = 'none';
			}
		}
	});
}

function checkPuntoNuevoLenguaje() {
	var formData = new FormData();
	formData.append("id", document.getElementById("idPunto").value);
	$.ajax({
		url : "checkAgregarLenguajePunto",
		type : "GET",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
		success: function (data) {
			if (data == true) {
				document.getElementById('point_of_interest_add_language_btn').style.display = 'none';
			}
		}
	});
}

function guardarAtraccionNuevoLenguaje() {
	hayError = 0;
	hayError = validarElemento('atraccionDescripcionNuevoLenguaje', 'mensajeDescripcionVaciaAtraccionNuevoLenguajeError', hayError);
	if(hayError == 1) {
		return;
	}
	var formData = new FormData();
	formData.append("id","${id}");
	formData.append("descripcion",document.getElementById("atraccionDescripcionNuevoLenguaje").value);
	formData.append("horario",document.getElementById("atraccionHorarioNuevoLenguaje").value);
	formData.append("precio",document.getElementById("atraccionPrecioNuevoLenguaje").value);
	formData.append("audio",document.getElementById("archivoAudioguiaAtraccionNuevoLenguaje").files[0]);
	$.ajax({
		url : "agregarLenguajeAtraccion",
		type : "POST",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
		success: function (data) {
			closeAtractionNewLanguagePopup();
			document.getElementById('atraction_add_language_btn').style.display = 'none';
		}
	});
}

function guardarPuntoNuevoLenguaje() {
	hayError = 0;
	hayError = validarElemento('puntoDescripcionNuevoLenguajeTextarea', 'mensajeDescripcionVaciaPuntoDeInteresNuevoLenguajeError', hayError);
	if(hayError == 1) {
		return;
	}
	var formData = new FormData();
	formData.append("id",document.getElementById("idPunto").value);
	formData.append("descripcion",document.getElementById("puntoDescripcionNuevoLenguajeTextarea").value);
	formData.append("audio",document.getElementById("archivoAudioguiaPuntoDeInteresNuevoLenguaje").files[0]);
	$.ajax({
		url : "agregarLenguajePunto",
		type : "POST",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
		success: function (data) {
			closePointOfInterestNewLanguagePopup();
			checkPuntoNuevoLenguaje();
			document.getElementById('point_of_interest_add_language_btn').style.display = 'none';
		}
	});
}
</script>
		
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKp5v5dZ8eFIHFp7Ek1cvIhrOwKv7XMtA&libraries=places,geometry&callback=initMap&language=es" async defer></script>

</body>
</html>
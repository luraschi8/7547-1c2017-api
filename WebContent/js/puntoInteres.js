const MAX_DESCRIPCION_PUNTO_DE_INTERES = "250";
$("#puntoDescripcion").attr("maxlength", MAX_DESCRIPCION_PUNTO_DE_INTERES);

$(function() {
	$("#sortable").sortable();
	$("#sortable").disableSelection();
});

$('#botonGuardarPuntoDeInteres').on('click', function(e) {
	e.preventDefault();
	if (validarPunto() == false) {
		return;
	}
	var formData = new FormData();
	formData.append("imagen",document.getElementById("puntoArchivoImagen").files[0]);
	formData.append("audio",document.getElementById("archivoAudioguiaPdi").files[0]);
	formData.append("nombre",document.formNuevoPuntoDeInteres.nombre.value);
	formData.append("descripcion",document.formNuevoPuntoDeInteres.descripcion.value);
	var json = {
			"nombre": document.formNuevoPuntoDeInteres.nombre.value,
			"descripcion": document.formNuevoPuntoDeInteres.descripcion.value
	};
	
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
				table.ajax.reload();
				closeNewPointOfInterestForm();
			}
		}
	});
	
});

function validarPunto() {
	hideAllPointOfInterestErrorMessages();
	var hayError = 0;
	hayError = validarElemento('puntoNombre', 'mensajeNombreVacioPuntoDeInteresError', hayError);
	hayError = validarElemento('puntoDescripcion', 'mensajeDescripcionVaciaPuntoDeInteresError', hayError);
	validarPuntoDeInteresRepetido();
}

function validarPuntoDeInteresRepetido() {
	
}

function disableAtractionPage() {
	$("#attractionForm").addClass("disable-buttons");
	$(".btn-final").addClass("disable-buttons");
	$(".atraction-new-page-header").addClass("disable-buttons");
}

function openNewPointOfInterestForm() {
	hideAllAtractionErrorMessages();
	document.getElementById('atraction-point-of-interest-popup-form').style.display = 'block';
	document.getElementById('atraction-point-of-interest-popup-form').focus();
	document.getElementById('attractionForm').blur();
	disableAtractionPage();
}

function openViewCommentPopUp() {
	hideAllAtractionErrorMessages();
	document.getElementById('atraction-comment-popup').style.display = 'block';
	document.getElementById('atraction-comment-popup').focus();
	document.getElementById('attractionForm').blur();
	disableAtractionPage();
}

function enableAtractionPage() {
	$("#attractionForm").removeClass("disable-buttons");
	$(".btn-final").removeClass("disable-buttons");
	$(".atraction-new-page-header").removeClass("disable-buttons");
}

function closeNewPointOfInterestForm() {
	document.getElementById('atraction-point-of-interest-popup-form').style.display = 'none';
	document.getElementById('puntoNombre').value = '';
	document.getElementById('puntoDescripcion').value = '';
	document.getElementById('puntoImagen').src = '//:0';
	document.getElementById('puntoAudio').src = '';
	hideAllPointOfInterestErrorMessages();
	enableAtractionPage();
}

function closeViewCommentPopUp() {
	document.getElementById('atraction-comment-popup').style.display = 'none';
	enableAtractionPage();
}

$(document).ready(function() {
	validateImage("puntoGetImagen", "puntoArchivoImagen", "puntoImagen", "mensajeImagenIncorrectaPuntoDeInteresError");
	validateAudio("puntoGetAudio", "borrarAudioPdi", "archivoAudioguiaPdi", "puntoAudio", "audioCambiadoPdi", "mensajeAudioPdiTamano", "mensajeAudioPdiIncorrectoError");
});

function updatePointOfInterestForm() {
	document.formNuevoPuntoDeInteres.nombre.value = $('#pdi-nombre').val();
	document.formNuevoPuntoDeInteres.descripcion.value = $('#pdi-descripcion').val();
	document.formNuevoPuntoDeInteres.orden.value = atraccion.cantPuntos;
}


function hideAllPointOfInterestErrorMessages() {
	document.getElementById('mensajeNombreVacioPuntoDeInteresError').style.display = 'none';
	document.getElementById('mensajeDescripcionVaciaPuntoDeInteresError').style.display = 'none';
	document.getElementById('mensajeImagenIncorrectaPuntoDeInteresError').style.display = 'none';
	document.getElementById('mensajeAudioPdiTamano').style.display = 'none';
	document.getElementById('mensajeAudioPdiIncorrectoError').style.display = 'none';
	document.getElementById('mensajeNombrePuntoDeInteresRepetido').style.display = 'none';
}

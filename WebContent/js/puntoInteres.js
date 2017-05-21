const MAX_DESCRIPCION_PUNTO_DE_INTERES = "250";
$("#puntoDescripcionTextarea").attr("maxlength", MAX_DESCRIPCION_PUNTO_DE_INTERES);

const MAX_NOMBRE_PUNTO_DE_INTERES = "50";
$("#puntoNombreTextarea").attr("maxlength", MAX_NOMBRE_PUNTO_DE_INTERES);

var ordenPuntos = '';

$(function() {
	$("#sortable").sortable({
		placeholder:    'sort-placeholder',
	    forcePlaceholderSize: true,
	    start: function( e, ui )
	    {
	    	ui.item.data( 'start-pos', ui.item.index()+1 );
	    },
	    change: function( e, ui ) {
	    	var seq,
	    	startPos = ui.item.data( 'start-pos' ),
	    	$index,
	    	correction;
	    	ordenPuntos = '';
	    	correction = startPos <= ui.placeholder.index() ? 0 : 1;
	    	ui.item.parent().find('tr').each( function( idx, el ) {
	    		var $this = $( el ),
	    		$index = $this.index();
	            if (($index+1 >= startPos && correction === 0) || ($index+1 <= startPos && correction === 1)) {
	            	$index = $index + correction;
	            	$this.find('.ordinal-position').text($index);
	            	var id = $this.find('.clasePuntoId').text();
	            	if (id != undefined && id != "" && $index != 0) {
	            		var idOrden = id + "," + $index;
	            		ordenPuntos += idOrden + ";";
	            	}
	            }
	    	});
	    	seq = ui.placeholder.index() + correction;
	    	var idOrden = ui.item.find('.clasePuntoId').text() + "," + seq;
	    	ordenPuntos += idOrden + ";";
	    	ui.item.find('.ordinal-position').text(seq);
	    	console.log(ordenPuntos);
	    },
	    stop: function(e, ui) {
	    	guardarOrden();
	    }
	});
	$("#sortable").disableSelection();
});

function guardarOrden() {
	var formData = new FormData();
	formData.append("ordenPuntos",ordenPuntos);
	var json = {
		"ordenPuntos": ordenPuntos	
	};
	$.ajax({
		url : "cambiarOrden",
		type : "POST",
		data : formData,
		enctype: 'multipart/form-data',
		processData : false,
		contentType: false,
		dataType: 'json',
	});
}

function validarPunto() {
	hideAllPointOfInterestErrorMessages();
	var hayError = 0;
	hayError = validarElemento('puntoNombreTextarea', 'mensajeNombreVacioPuntoDeInteresError', hayError);
	hayError = validarElemento('puntoDescripcionTextarea', 'mensajeDescripcionVaciaPuntoDeInteresError', hayError);
	if ((document.getElementById('puntoImagen').src == '' || document.getElementById('puntoImagen').src == 'http://:0/') && (!hayError)) {
		document.getElementById('mensajeImagenVaciaPuntoDeInteresError').style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById('mensajeImagenVaciaPuntoDeInteresError').style.display = 'none';
	}
	if (hayError == 1) {
		return false;
	}
	validarPuntoDeInteresRepetido();
}

function validarEdicionPunto() {
	hideAllPointOfInterestErrorMessages();
	var hayError = 0;
	hayError = validarElemento('puntoNombre', 'mensajeNombreVacioPuntoDeInteresError', hayError);
	hayError = validarElemento('puntoDescripcion', 'mensajeDescripcionVaciaPuntoDeInteresError', hayError);
	if ((document.getElementById('puntoImagen').src == '' || document.getElementById('puntoImagen').src == 'http://:0/') && (!hayError)) {
		document.getElementById('mensajeImagenVaciaPuntoDeInteresError').style.display = 'block';
		hayError = 1;
	} else {
		document.getElementById('mensajeImagenVaciaPuntoDeInteresError').style.display = 'none';
	}
	if (hayError == 1) {
		return false;
	}
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
	document.getElementById('puntoNombreTextarea').value = '';
	document.getElementById('puntoDescripcionTextarea').value = '';
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
	document.getElementById('mensajeImagenVaciaPuntoDeInteresError').style.display = 'none';
	document.getElementById('mensajeAudioPdiTamano').style.display = 'none';
	document.getElementById('mensajeAudioPdiIncorrectoError').style.display = 'none';
	document.getElementById('mensajeNombrePuntoDeInteresRepetido').style.display = 'none';
};

function showCreationElements() {
	var puntoCreacion = document.getElementsByClassName("puntoCreacion");
    for(var i = 0; i < puntoCreacion.length; i++) {
    	puntoCreacion[i].style.display = "block";
    }
    var puntoCreacionInline = document.getElementsByClassName("puntoCreacionInline");
    for(var i = 0; i < puntoCreacionInline.length; i++) {
    	puntoCreacionInline[i].style.display = "inline-block";
    }
    var puntoEdicion = document.getElementsByClassName("puntoEdicion");
    for(var i = 0; i < puntoEdicion.length; i++) {
    	puntoEdicion[i].style.display = "none";
    }
    var puntoEdicionInline = document.getElementsByClassName("puntoEdicionInline");
    for(var i = 0; i < puntoEdicionInline.length; i++) {
    	puntoEdicionInline[i].style.display = "none";
    }
}

function showEditionElements() {
	var puntoCreacion = document.getElementsByClassName("puntoCreacion");
    for(var i = 0; i < puntoCreacion.length; i++) {
    	puntoCreacion[i].style.display = "none";
    }
    var puntoCreacionInline = document.getElementsByClassName("puntoCreacionInline");
    for(var i = 0; i < puntoCreacionInline.length; i++) {
    	puntoCreacionInline[i].style.display = "none";
    }
    var puntoEdicion = document.getElementsByClassName("puntoEdicion");
    for(var i = 0; i < puntoEdicion.length; i++) {
    	puntoEdicion[i].style.display = "block";
    }
    var puntoEdicionInline = document.getElementsByClassName("puntoEdicionInline");
    for(var i = 0; i < puntoEdicionInline.length; i++) {
    	puntoEdicionInline[i].style.display = "inline-block";
    }
}
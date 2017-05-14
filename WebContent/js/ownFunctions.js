function validateImage(button_id, file_id, image_id, message_id) {
	document.getElementById(button_id).onclick = function() {
		document.getElementById(file_id).addEventListener('change', readURL, true);
		var fileButton = document.getElementById(file_id);
		fileButton.click();
	};
	
	var file_id_aux = "#" + file_id;
	
	$(file_id_aux).change(function() {
	    var val = $(this).val();
	    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
	        case 'gif': case 'jpg': case 'png': case 'jpeg': case 'bmp': 
	        	document.getElementById(message_id).style.display = 'none';
	        	break;
	        default:
	            $(this).val('');
				document.getElementById(message_id).style.display = 'block';
				document.getElementById(file_id).value = "" ;
				document.getElementById(image_id).src = "" ;
				break;
	    }
	});
	
	function readURL(){
		var file = document.getElementById(file_id).files[0];
		var reader = new FileReader();
	    reader.onloadend = function(){
			document.getElementById(image_id).src = reader.result;
		}
		if(file) {
			reader.readAsDataURL(file);
		} 
	}
}

function hideMessage(message) {
	if (document.getElementById(message) != null) {
		document.getElementById(message).style.display = "none";
	}
}

function hideAllAtractionErrorMessages() {
	hideMessage("mensajeNombreVacio");
	hideMessage("mensajeDescripcionVacia");
	hideMessage("mensajePlanoNecesario");
	hideMessage("mensajeImagenIncorrectaError");
	hideMessage("mensajeHayVideo");
	hideMessage("mensajeCincoArchivos");
	hideMessage("mensajeTamanoImagen");
	hideMessage("mensajeTamanoVideo");
	hideMessage("mensajeUnaImagen");
	hideMessage("mensajeAudioIncorrectoError");
	hideMessage("mensajeUbicacionVacia");
	hideMessage("mensajeUbicacionLejana");
	hideMessage("mensajeNombreRepetido");
	hideMessage("mensajeAudioTamano");
	hideMessage("mensajePuntoDeInteresNecesario");
}

function saveField(field, ok, cancel, vacio, obligatorio) {
	hideAllAtractionErrorMessages();
	hideEdition(field, ok, cancel);
	var new_field = "#" + $(field).attr("id") + "Textarea";
	if (($(new_field).val()) || (!obligatorio)) {
		$(field).html($(new_field).val());
	} else {
		if (obligatorio) {
			document.getElementById(vacio).style.display = "block";
		}
	}
	$(field).show();
}

function cancelField(field, ok, cancel) {
	hideAllAtractionErrorMessages();
	hideEdition(field, ok, cancel);
	$(field).show();
}

function calculateMaxLength(field, max) {
	var count = 0;
	for (var i = 0; i < max; i++) {
		if ($(field).val()[i] == '\n') {
			count++;
		}
	}
	$(field).attr("maxlength", max - count);
}

function editField(field, ok, cancel, vacio, obligatorio) {
	hideAllAtractionErrorMessages();
	$(field).hide();
	var new_field = $(field).attr("id") + "Textarea";
	document.getElementById(new_field).style.display = "inline-block";
	document.getElementById(new_field).value = $(field).html();
	if (obligatorio) {
		document.getElementById(vacio).style.display = "none";
	}
	if (!$(field).val()) {
		$(field).val($(field).html());
	}
    displayOkAndCancelButtons(ok, cancel);
}

function displayOkAndCancelButtons(ok, cancel) {
	document.getElementById(ok).style.display = "inline-block";
    document.getElementById(cancel).style.display = "inline-block";
}

function hideTextarea(field) {
    var new_field = $(field).attr("id") + "Textarea";
	document.getElementById(new_field).style.display = "none";
}

function hideOkAndCancelButtons(ok, cancel) {
	document.getElementById(ok).style.display = "none";
    document.getElementById(cancel).style.display = "none";
}

function hideEdition(field, ok, cancel) {
	hideTextarea(field);
	hideOkAndCancelButtons(ok, cancel);
}

function validateAudio(btn_get, btn_erase, file_id, audio, modified_audio, size_msg, incorrect_audio_msg) {
	document.getElementById(btn_erase).onclick = function() {
		document.getElementById(file_id).value = "" ;
		document.getElementById(audio).src = "" ;
		document.getElementById(modified_audio).value = 1;
	};
	
	document.getElementById(btn_get).onclick = function() {
		hideAllAtractionErrorMessages();
		hideAllRouteErrorMessages();
		document.getElementById(file_id).addEventListener('change', readURL, true);
		var fileButton = document.getElementById(file_id);
		fileButton.click();
	};
	
	var file_str = "#" + file_id;
	$(file_str).change(function() {
       	document.getElementById(modified_audio).value = 1;
       	var file = document.getElementById(file_id).files[0];
	    var val = $(this).val();
	    document.getElementById(size_msg).style.display = 'none';
	    document.getElementById(incorrect_audio_msg).style.display = 'none';
	    switch(val.substring(val.lastIndexOf('.') + 1).toLowerCase()){
	        case 'mp3':
	        	if (file.size > (3 * 1024 * 1024)) {
	        		document.getElementById(size_msg).style.display = 'block';
	        		document.getElementById(file_id).value = "" ;
					document.getElementById(audio).src = "" ;
	        		return;
	        	}
	        	break;
	        default:
	            $(this).val('');
				document.getElementById(incorrect_audio_msg).style.display = 'block';
				document.getElementById(file_id).value = "" ;
				document.getElementById(audio).src = "" ;
				break;
	    }
	});
	
	function readURL() {
		var file = document.getElementById(file_id).files[0];
		var reader = new FileReader();
	    reader.onloadend = function(){
			document.getElementById(audio).src = reader.result;
		}
		if(file) {
			reader.readAsDataURL(file);
		} 
	}
}

function hideAllAtractionNewLanguageErrorMessages() {
	document.getElementById('mensajeDescripcionVaciaAtraccionNuevoLenguajeError').style.display = 'none';
	document.getElementById('mensajeAudioAtraccionNuevoLenguajeIncorrectoError').style.display = 'none';
	document.getElementById('mensajeAudioAtraccionNuevoLenguajeTamano').style.display = 'none';
}

function showAtractionNewLanguagePopup() {
	document.getElementById("atraction_new_language_popup").style.display = 'block';
	document.getElementById('atraction_new_language_popup').focus();
	document.getElementById('attractionForm').blur();
	disableAtractionPage();
}

function closeAtractionNewLanguagePopup() {
	document.getElementById('atraction_new_language_popup').style.display = 'none';
	document.getElementById('atraccionDescripcionNuevoLenguaje').value = '';
	document.getElementById('atraccionHorarioNuevoLenguaje').value = '';
	document.getElementById('atraccionPrecioNuevoLenguaje').value = '';
	document.getElementById('audioAtraccionNuevoLenguaje').src = '';
	hideAllAtractionNewLanguageErrorMessages();
	enableAtractionPage();
}

function hideAllRouteErrorMessages() {
	hideMessage("mensajeNombreVacio");
	hideMessage("mensajeDescripcionVacia");
	hideMessage("mensajeNingunaAtraccionElegida");
	hideMessage("mensajeNombreRepetido");
	hideMessage("mensajeAudioRecorridoIncorrectoError");
	hideMessage("mensajeAudioRecorridoTamano");
}

function disableRoutePage() {
	$("#routeForm").addClass("disable-buttons");
	$(".btn-final").addClass("disable-buttons");
	$(".route-new-page-header").addClass("disable-buttons");
}

function enableRoutePage() {
	$("#routeForm").removeClass("disable-buttons");
	$(".btn-final").removeClass("disable-buttons");
	$(".route-new-page-header").removeClass("disable-buttons");
}

function hideAllRouteNewLanguageErrorMessages() {
	document.getElementById('mensajeDescripcionVaciaRecorridoNuevoLenguajeError').style.display = 'none';
	document.getElementById('mensajeAudioRecorridoNuevoLenguajeIncorrectoError').style.display = 'none';
	document.getElementById('mensajeAudioRecorridoNuevoLenguajeTamano').style.display = 'none';
}

function showRouteNewLanguagePopup() {
	document.getElementById("route_new_language_popup").style.display = 'block';
	document.getElementById('route_new_language_popup').focus();
	document.getElementById('routeForm').blur();
	disableRoutePage();
}

function closeRouteNewLanguagePopup() {
	document.getElementById('route_new_language_popup').style.display = 'none';
	document.getElementById('recorridoDescripcionNuevoLenguaje').value = '';
	document.getElementById('audioRecorridoNuevoLenguaje').src = '';
	hideAllRouteNewLanguageErrorMessages();
	enableRoutePage();
}
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
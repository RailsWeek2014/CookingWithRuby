function Validation() {
	var self = this;
	
	self.isValid = function(form, cb_success, cb_failed) {
		var ret = true;
		var errorMessage = "Required fields: ";
		var elements = $('[validation]', form);
		var i = 0;
		elements.each(function() {
			var elem = $(this);
			param = elem.attr('validation');
			if(param == "notBlank" && elem.val() == ""){
				ret = false;
				if(elem.parent().siblings('label').text() != "")
					errorMessage += elem.parent().siblings('label').text();
				else
					errorMessage += elem.parent().parent().siblings('label').text();
				if(i < elements.length - 1){
					errorMessage += ", "
				}
				i++;
			}
		});
		
		if(ret) {
			if(cb_success !== undefined)
				cb_success();
		} else {
			var errorField = $('#errorField', form);
			errorField.empty().append(errorMessage);
			errorField.removeClass("hide");
			if(cb_failed !== undefined)
				cb_failed();			
		}
	};
}

function recipe() {
	var self = this;
	var modal = undefined;
	var modal_path = undefined;
		
	self.add_to_cookbooks = function() {
		$.get(window.location.pathname + '/add_to_cookbook', function(html) {
			modal = $(html);
			$('button.close', modal).click(function() {
				modal.fadeOut(function() {
					modal.remove();
					modal = undefined;
				});
			});
			
			$('body').append(modal);
			modal.fadeIn();
		});
	};

	self.post = function() {
		var form_data = $('form', modal).serializeArray();
		$.post('/cookbooks/' + form_data[3]['value'] + '/create_entry', form_data, function() {
			$('button.close', modal).click();
		});
	};
}
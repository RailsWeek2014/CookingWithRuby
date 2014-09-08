
function recipe() {
	var self = this;
	var modal = undefined;
	var modal_path = undefined;
		
	self.add_to_cookbooks = function() {
		create('/cookbooks/');
	};

	function create(path) {
		var window = null;
		$.get(path + 'add', function(html) {
			modal = $(html);
			modal_path = path;
			$('button.close', modal).click(function() {
				modal.fadeOut(function() {
					modal.remove();
					modal_path = undefined;
					modal = undefined;
				});
			});
			
			$('body').append(modal);
			modal.fadeIn();
		});
	};

	self.post = function() {
		var form_data = $('form', modal).serializeArray();
		$.post(modal_path, form_data, function() {
			self.update(true);
			$('button.close', modal).click();
		});
	};
}
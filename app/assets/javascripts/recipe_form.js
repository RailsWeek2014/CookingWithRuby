/**
 * New node file
 */

function recipe_form() {
	var self = this;
	var modal = undefined;
	var modal_path = undefined;
	
	var list = [];
	
	self.new_ingredient = function() {
		create('/ingredients/');
	};

	self.new_category = function() {
		create('/categories/');
	};

	self.new_unit = function() {
		create('/units/');
	};

	function create(path) {
		var window = null;
		$.get(path + 'new', function(html) {
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

	self.update = function(reload, type) {
		if(typeof type === "object") {
			type.forEach(function(entry) {
				self.update(reload, entry);
			});
		} else if(reload) {
			$.getJSON('/json' + ((modal_path !== undefined)?modal_path:'/json/' + type + 's'), function(json) {
				console.log(json);
				list[(type !== undefined)?type:json.type] = json.entries;
				self.update(false, json.type);
			});	
		} else {
			var selects = $("select").filter(function() {
				return this.id.match("recipe_.*_attributes_.+_"+type+"_id");
			});
			$('option', selects).filter(function() {
				return this.value.match(".+"); 
			}).remove();
			list[type].forEach (function(entry) {
				selects.append('<option value="' + entry.id + '">' + entry.name + "</option>");
			});
			$.each(selects, function(i, select) {
				self.select2button($(select).prop('name'));
			});
		}
	};
	
	self.select2button = function(name) {
		if(name === undefined) {
			var types = ['ingredient', 'unit', 'category'];
			types.forEach(function(type) {
				self.select2button(type);
			});
		} else {
			var btn = $('button[name="' + name + '"]').first();
			var select = btn.siblings('select');
			var ul = btn.siblings('ul');
			var name = select.prop('name');
			ul.attr('name', name);
			btn.prop('name', name);
			
			ul.empty();
			$('option', select).each(function() {
				var option = $(this);
				var li = $('<li>' + option.text() + '</li>');
				li.click(function() {
					option.attr('selected',true);
					option.siblings().attr('selected', false);
					btn.text(option.text() + ' ');
					btn.append('<span class="caret"/>');
				});
				if(option.attr('selected')) {
					btn.text(option.text() + ' ');
					btn.append('<span class="caret"/>');
				}
				ul.append(li);
			});			
		}
	};
}
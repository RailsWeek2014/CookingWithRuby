/**
 * New node file
 */


function new_ingredient() {
	var window = null;
	$.get('/ingredients/new', function(html) {
		window = $(html);
		
		$('button.close', window).click(function() {
			window.fadeOut(function() {
				window.remove();
				update_ingredient();
			});
		});
		
		$('body').append(window);
		window.fadeIn();
	});
}

function post_new_ingredient() {
	var window = $('div.modal');
	var form_data = $('form#new_ingredient', window).serializeArray();
	$.post('/ingredients/', form_data, function() {
		$('button.close', window).click();
	});
}

function update_ingredient() {
	$.get('/json/ingredients/', function(json) {
		console.log(json);
	});	
}
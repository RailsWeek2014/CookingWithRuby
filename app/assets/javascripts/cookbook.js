function Cookbook() {
	var self = this;
	
	this.edit = function(id){
		var field = $('td#'+id);
		field.empty();
		$.get('/cookbooks/' + id + '/edit', null, function(html){
			field.append(html);
		});
	};
	
	this.newEntry = function(id){
		if($('tr#newCookbook').length === 0){
			var field = $('table');
			$.get('/cookbooks/new', null, function(html){
				field.append('<tr id="newCookbook"><td></td><td>'+html+'</td><td></td></tr>');
			});
		}
	};
}
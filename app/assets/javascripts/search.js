function Search() {
	var self = this;
	var searchfield =$('#keywords');
	var results = undefined;
	var timeout = undefined;
	
	self.search = function(type) {
		clearTimeout(timeout);
		timeout = setTimeout(function() {
			if(results === undefined)
				results = $('#searchresults');
			if(type == "change") {
				var words = searchfield.val();
				console.log(words);
				$.post('/search/search', {keywords: words}, function(result) {
					console.log(result);
				});
			}
		}, 500);
	};
	
	searchfield.keyup(function() {
//no instant results at the moment :(
//		self.search('change');
	});
}
function Comments() {
	var self = this;
	function functions() {
		this.create = function(recipe_id) {
			console.log("Create a new Comment for: " + recipe_id);
		};
		
		this.answer = function(recipe_id, comment_id) {
			console.log("Answer to Comment: " + comment_id);
		};
		
		this.edit = function(recipe_id, comment_id) {
			console.log("Edit to Comment: " + comment_id);
		};

		this.remove = function(recipe_id, comment_id) {
			var del = window.confirm("Are you sure?");
			if(del)
				deleteComment(comment_id);
		};
	};
	var func = new functions();
	
	self.link_buttons = function() {
		$('[name="comments"] a').each(function() {
			var a = $(this);
			var f = a.prop('href').split( '/' );
			f = f[f.length-1];
			a.removeAttr('href');
			var recipe_id = $('[name="comments"]').prop('id'); 
			var comment_id = a.closest('.comment').prop('id');
			console.log(f + ": " + recipe_id + ": " + comment_id); 
			a.click(function() {
				func[f](recipe_id, comment_id);
			});
		});
	};
	
	function deleteComment(comment_id) {
        $.ajax({
		    url: '/comments/' + comment_id,
		    type: 'DELETE',
		    success: function(result) {
		        console.log("Deleted!");
		    },
		    error: function(result) {
		    	console.log("Not deleted!");
		    }
		});
	}
}
function Comments() {
	var self = this;
	var selector = undefined;
	
	function functions() {
		this.create = function(parent, recipe_id) {
			createNewComment(parent, recipe_id);
		};
		
		this.answer = function(parent, recipe_id, comment_id) {
			createNewAnswerComment(parent, comment_id);
		};
		
		this.edit = function(parent, recipe_id, comment_id) {
			editComment(parent, comment_id);
		};

		this.remove = function(parent, recipe_id, comment_id) {
			var del = window.confirm("Are you sure?");
			if(del)
				deleteComment(comment_id);
		};
		
		this.remove_form = function(parent) {
			parent.closest('form').remove();
		};
	};
	var func = new functions();
	
	self.link_buttons = function() {
		selector = $('[name="comments"]');
		$('[name="comments"] a').each(function() {
			var a = $(this);
			var f = a.prop('href').split( '/' );
			f = f[f.length-1];
			if(f !== "") {
				a.removeAttr('href');
				var recipe_id = selector.prop('id'); 
				var comment_id = a.closest('.comment').prop('id');
				console.log(f + ": " + recipe_id + ": " + comment_id); 
				a.click(function() {
					func[f](a.parent(), recipe_id, comment_id);
				});
			}
		});
	};
	
	function deleteComment(comment_id) {
        $.ajax({
		    url: '/comments/' + comment_id,
		    type: 'DELETE',
		    success: function(result) {
		        console.log("Deleted!");
				location.reload();		        
		    },
		    error: function(result) {
		    	console.log("Not deleted!");
		    }
		});
	}
	
	function createNewComment(parent, recipe_id) {
		$.get('/comments/new/' + recipe_id, null, function(html) {
			selector.append(html).append(parent);
		});
	};

	function createNewAnswerComment(parent, comment_id) {
		$.get('/comments/answer_to/' + comment_id, null, function(html) {
			var c_parent = parent.closest('.comment').parent();
			var answers = $('.col-sm-offset-1', parent);
			if(answers.length == 0) {
				answers = $('<div class="col-sm-offset-1">');
				c_parent.append(answers);
			}
			var tmp = $('<div class="comment" style="display: flex; margin-bottom: 10px" id="5">').append(html);
		    tmp = $('<div class="answer">').append(tmp);
		    answers.append(tmp);
		});
	};
	
	function editComment(parent, comment_id) {
		$.get('/comments/' + comment_id + '/edit', null, function(html) {
			parent.closest('.comment').empty().append(html);
		});
	}
	
	self.post = function(id) {
		var form = $("#"+id).closest('form');
		id = $('#comment_id', form).val();
		var form_data = form.serializeArray();
		$.post("/comments/" + id, form_data, function() {
			location.reload();
		});
	};
}
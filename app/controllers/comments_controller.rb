class CommentsController < ApplicationController
  
  def new
    @comment.recipe_id = params[:id]
      
    render 'form', layout: false
  end

  def edit
    render 'form', layout: false
  end

  def answer
    @comment = Comment.new
    @comment.answer_to_id = params[:id]
    @comment.recipe_id = Comment.find(params[:id]).recipe_id
    
    render 'form', layout: false
  end

  def create
    if @comment.save
      current_user.comments << @comment
      render text: "ok"
    else
      render text: "nok"
    end
  end

  def update
    if @comment.update_attributes(comment_params)
      render text: "ok"
    else
      render text: "nok"
    end
  end

  def destroy
    @comment.destroy
    
    render text: "ok"
  end

  private
    def comment_params
      params.require( 'comment' ).permit( 'message', 'recipe_id', 'answer_to_id')
    end
end

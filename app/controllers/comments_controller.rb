class CommentsController < ApplicationController
  
  def new
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    @comment = Comment.new
    @comment.recipe_id = params[:id]
      
    render 'form', layout: false
  end

  def edit
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    @comment = Comment.find(params[:id])
    render 'form', layout: false
  end

  def answer
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    @comment = Comment.new
    @comment.answer_to_id = params[:id]
    @comment.recipe_id = Comment.find(params[:id]).recipe_id
    
    render 'form', layout: false
  end

  def create
    @comment = Comment.new comment_params
    
    if @comment.save
      current_user.comments << @comment
      render text: "ok"
    else
      render text: "nok"
    end
  end

  def update
    @comment = Comment.find(params[:id])
      
    if @comment.update_attributes(comment_params)
      render text: "ok"
    else
      render text: "nok"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
#    if(user_sign_in?)
#      if(current_user.id == @comment.user_id)
        @comment.destroy
#      end
#    end
    render text: "ok"
  end

  private
    def comment_params
      params.require( 'comment' ).permit( 'message', 'recipe_id', 'answer_to_id')
    end
end

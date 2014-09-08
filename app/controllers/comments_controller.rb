class CommentsController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def destroy
    @comment = Comment.find(params[:id])
#    if(user_sign_in?)
#      if(current_user.id == @comment.user_id)
        @comment.destroy
#      end
#    end
    redirect_to recipes_url
  end

end

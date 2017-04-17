class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment
  before_action :set_back_to_url
  before_action :check_comment_user

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @back_to_url
    else
      render :edit
    end
  end

private

  def comment_params
    params.require(:comment).permit(:title, :text)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def check_comment_user
    return if current_user.admin?

    if !@comment.belongs_to?(current_user)
      redirect_to @back_to_url
    end
  end

  def set_back_to_url
    @back_to_url = commentable_url(@comment.commentable)
  end


end

class ItemsController < ApplicationController
  before_action :require_subscription
  before_action :set_vars
  before_action :set_discussion_variables

  def show
  end

  def create_comment
    @comment.attributes = comment_params
    @comment.user = current_user
    @comment.discussion = Discussion.friendly.find(params[:discussion_id])

    if @comment.save
      # NotifyNewCommentOnDiscussionJob.perform_later(@comment.id)

      redirect_to action: :show, anchor: "comment_#{@comment.id}"
    else
      render :show
    end
  end

private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_discussion_variables
    return if params[:discussion_id].blank?
    @comment = Comment.new
    @active_discussion = Discussion.friendly.find(params[:discussion_id])
  end

  def set_vars
    @lesson = Lesson.friendly.find(params[:lesson_id])
    @item = Item.for(@lesson, params[:item_weight])
    @course = Course.friendly.find(params[:course_id])
  end

end

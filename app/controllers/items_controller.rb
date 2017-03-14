class ItemsController < ApplicationController
  before_filter :set_vars
  before_filter :set_discussion_variables

  def show
    # answer = Answer.for(current_user, @item)
    # @answered_alternative = answer && answer.alternative.as_json
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

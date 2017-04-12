class ItemsController < ApplicationController
  before_action :require_subscription
  before_action :set_vars, except: [:mark_as_done]
  before_action :set_discussion_variables, except: [:mark_as_done]

  def show
    if params[:discussion_id].blank?
      discussion = @item.discussions.first

      redirect_to anchor_discussion_path(discussion, anchor: false) if discussion.present?
    end
  end

  def create_comment
    @comment.attributes = comment_params
    @comment.user = current_user
    @comment.commentable = Discussion.friendly.find(params[:discussion_id])

    if @comment.save
      redirect_to action: :show, anchor: "comment_#{@comment.id}"
    else
      render :show
    end
  end

  def mark_as_done
    @item = Item.find(params[:item_id])
    @item.done!
    render :mark_as_done
  end

private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_discussion_variables
    return if params[:discussion_id].blank?
    @comment = Comment.new
    @active_discussion = Discussion.includes(:user, comments: :user).friendly.find(params[:discussion_id])
  end

  def set_vars
    @lesson = Lesson.friendly.find(params[:lesson_id])
    @item = Item.for(@lesson, params[:item_weight])
    @course = Course.friendly.find(params[:course_id])
  end

end

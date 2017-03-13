class DiscussionsController < ApplicationController

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user = current_user
    @discussion.item = item

    if @discussion.save
      redirect_to discussion_path(lesson.course, lesson, item, @discussion)
    else
      render :new
    end
  end

private

  def discussion_params
    params.require(:discussion).permit(:title, :text)
  end

  def item
    @item ||= Item.for(lesson, params[:item_weight])
  end

  def lesson
    @lesson ||= Lesson.friendly.find(params[:lesson_id])
  end

end

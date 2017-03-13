class ItemsController < ApplicationController
  before_filter :set_discussion_variables, if: -> { is_discussion_path? }

  def show
    lesson = Lesson.friendly.find(params[:lesson_id])
    @item = Item.for(lesson, params[:item_weight])

    answer = Answer.includes(:alternative).for(current_user, @item)
    @answered_alternative = answer && answer.alternative.as_json
  end


private

  def is_discussion_path?
    params[:discussion_id].present?
  end

  def set_discussion_variables
    @comment = Comment.new
    @discussion = Discussion.friendly.find(params[:discussion_id])
  end

end

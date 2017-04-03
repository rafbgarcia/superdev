class CoursesController < ApplicationController
  before_action :require_subscription, only: [:show]

  def index
    @courses = Course.visible.by_weight
  end

  def show
    @course = Course.includes(lessons: :items).friendly.find(params[:course_id])
  end

end

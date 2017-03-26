class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.by_weight
  end

  def show
  end

  private

    def set_course
      @course = Course.includes(:lessons).friendly.find(params[:course_id])
    end

end

class Admin::CoursesController < AdminController
    before_action :set_course, only: [:edit, :update, :destroy]

    def index
      @courses = Course.by_weight
    end

    def new
      @course = Course.new
    end

    def edit
    end

    def create
      @course = Course.new(course_params)

      if @course.save
        redirect_to admin_courses_url, notice: 'Course was successfully created.'
      else
        render :new
      end
    end

    def update
      if @course.update(course_params)
        redirect_to admin_courses_url, notice: 'Course was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @course.destroy
      redirect_to admin_courses_url, notice: 'Course was successfully destroyed.'
    end

  private

    def set_course
      @course = Course.friendly.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :image, :weight, :description, :available_at, :visible)
    end

end

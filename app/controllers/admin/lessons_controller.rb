class Admin::LessonsController < AdminController
    before_action :set_lesson, only: [:edit, :update, :destroy, :update_weight]

    def index
      @lessons = Lesson.by_course
    end

    def new
      @lesson = Lesson.new
    end

    def edit
    end

    def create
      @lesson = Lesson.new(lesson_params)

      if @lesson.save
        redirect_to admin_lessons_url, notice: 'lesson was successfully created.'
      else
        render :new
      end
    end

    def update
      if @lesson.update(lesson_params)
        redirect_to admin_lessons_url, notice: 'lesson was successfully updated.'
      else
        render :edit
      end
    end

    def update_weight
      if @lesson.update_weight(lesson_params[:weight])
        redirect_to admin_lessons_url, notice: 'lesson was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @lesson.destroy
      redirect_to admin_lessons_url, notice: 'lesson was successfully destroyed.'
    end

  private

    def set_lesson
      @lesson = Lesson.friendly.find(params[:id] || params[:lesson_id])
    end

    def lesson_params
      params[:lesson]
    end

end

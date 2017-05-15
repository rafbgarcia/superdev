class Admin::ProjectsController < AdminController
    before_action :set_project, only: [:edit, :update, :destroy]

    def index
      @projects = Project.by_weight
    end

    def new
      @project = Project.new(weight: Project.count)
    end

    def edit
    end

    def create
      @project = Project.new(project_params)

      if @project.save
        redirect_to admin_projects_url, notice: 'Project was successfully created.'
      else
        render :new
      end
    end

    def update
      if @project.update(project_params)
        redirect_to admin_projects_url, notice: 'Project was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @project.destroy
      redirect_to admin_projects_url, notice: 'Project was successfully destroyed.'
    end

  private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :image, :weight, :description)
    end

end

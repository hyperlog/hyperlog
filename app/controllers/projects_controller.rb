class ProjectsController < ApplicationController
  layout 'user'

  before_action do
    @profile = current_user.profile
    @projects = @profile.projects
  end

  def index; end

  def show
    @project = @projects.find(params[:id])
    render json: @project
  end

  def edit
    @project = @projects.find(params[:id])
  end

  def update
    @project = @projects.find(params[:id])
    if @project.update(project_params)
      redirect_to edit_project_path(@project), notice: 'Updated successfully!'
    else
      redirect_to edit_project_path(@project), alert: 'Something went wrong'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :tagline, :description)
  end
end

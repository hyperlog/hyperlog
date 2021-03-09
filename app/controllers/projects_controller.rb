class ProjectsController < ApplicationController
  layout 'user'

  before_action do
    @profile = current_user.profile
    @projects = @profile.projects
  end

  def index; end

  def new; end

  def show
    @project = @projects.find(params[:id])
    render json: @project
  end

  def edit
    @project = @projects.find(params[:id])
  end

  def create
    create_params = project_params.merge(profile: current_user.profile)
    @project = Project.create(create_params)
    if @project.persisted?
      redirect_to projects_home_path, notice: 'Project created successfully!'
    elsif @project.errors.key?(:profile)
      redirect_to project_new_path,
                  alert: 'Something went wrong.' \
                         ' Did you try to create more than 5 projects?'
    else
      redirect_to project_new_path,
                  alert: @project.errors.full_messages.join(', ')
    end
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

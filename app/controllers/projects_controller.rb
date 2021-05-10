class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authenticate

  # GET /projects or /projects.json
  def index
    # @projects = Project.all
    @projects = Project.includes(:author).where('author_id = ?',
                                                current_user.id).joins(:groups_projects).most_recent
  end

  # GET /projects/1 or /projects/1.json
  def show; end

  def project_ungrouped
    @projects = Project.includes(:author).where('author_id = ?',
                                                current_user.id).left_outer_joins(:groups_projects).where('group_id IS NULL').most_recent
    render 'index'
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.author_id = current_user.id

    respond_to do |format|
      if @project.save
        # p params[:project][:group_id]
        group_id = params[:project][:group_id]
        GroupsProject.create(group_id: group_id, project_id: @project.id) if group_id
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def authenticate
    return if logged_in?

    flash[:alert] = 'You need to login or sign up to access'
    redirect_to '/log'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:group_id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :duration)
  end
end

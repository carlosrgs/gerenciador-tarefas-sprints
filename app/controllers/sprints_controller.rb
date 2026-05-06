class SprintsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sprint, only: %i[show edit update destroy]

  def index
    @sprints = current_user.sprints.order(start_date: :desc)
  end

  def show
    @tasks = @sprint.tasks.order(created_at: :asc)
    @task = Task.new
  end

  def new
    @sprint = current_user.sprints.build
  end

  def edit
  end

  def create
    @sprint = current_user.sprints.build(sprint_params)

    if @sprint.save
      redirect_to @sprint, notice: "Sprint criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @sprint.update(sprint_params)
      redirect_to @sprint, notice: "Sprint atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sprint.destroy
    redirect_to sprints_url, notice: "Sprint excluída com sucesso."
  end

  private

  def set_sprint
    @sprint = current_user.sprints.find(params[:id])
  end

  def sprint_params
    params.require(:sprint).permit(:name, :start_date, :end_date)
  end
end

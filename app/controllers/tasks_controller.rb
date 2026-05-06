class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sprint
  before_action :set_task, only: %i[edit update destroy change_status]

  def create
    @task = @sprint.tasks.build(task_params)

    if @task.save
      redirect_to @sprint, notice: "Tarefa criada com sucesso."
    else
      @tasks = @sprint.tasks.order(created_at: :asc)
      render "sprints/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @sprint, notice: "Tarefa atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to @sprint, notice: "Tarefa excluída com sucesso."
  end

  def change_status
    if Task::VALID_STATUSES.include?(params[:status])
      @task.update(status: params[:status])
      redirect_to @sprint, notice: "Status da tarefa atualizado para #{@task.status.humanize}."
    else
      redirect_to @sprint, alert: "Status inválido."
    end
  end

  private

  def set_sprint
    @sprint = current_user.sprints.find(params[:sprint_id])
  end

  def set_task
    @task = @sprint.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :story_points)
  end
end

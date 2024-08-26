class TasksController < ApplicationController
  # before_action :set_task, only: [:update, :destroy]
  # This before_action can't be used in home page because there is no :id in params

  def create
    @task = Task.new(task_params)
    @task.status = false unless @task.status
    @task.user = current_user
    if @task.save
      redirect_to home_path
    else
      redirect_to home_path, status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    @task.status = false
    if @task.save
      redirect_to home_path
    else
      redirect_to home_path, status: :unprocessable_entity
    end
  end

  def toggle_status
    @task = Task.find(params[:id])
    @task.update(status: !@task.status)
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Task status was successfully updated.' }
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status, :location, :start_time, :end_time, :user_id, :dog_id)
  end
end

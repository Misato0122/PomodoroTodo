class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
  end

  def show
    @task = Task.find(params[:id])
    @data = []
    d = Time.zone.today
    pomodoros = @task.pomodoros.group("date(created_at)").count
    (0..6).each do |a|
      @data.push([d - a, pomodoros[d - a]])
    end
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, success: 'タスク登録しました'
    else
      redirect_to tasks_path, danger: 'タスク作成に失敗しました'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.new(task_params)
    @task.update!
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy!
    redirect_to tasks_path, success: 'タスクを削除しました'
  end

private

  def task_params
    params.permit(:content, :deadline).merge(user_id: current_user.id)
  end
end

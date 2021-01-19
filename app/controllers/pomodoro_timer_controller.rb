class PomodoroTimerController < ApplicationController
  def timer
    @pomodoro = Pomodoro.new
    @task = Task.find(params[:id])
  end

  def create
    @pomodoro = Pomodoro.new(pomodoro_params)
    @pomodoro.save
    redirect_to tasks_path, success: 'ポモドーロ回数を更新しました！'
  end

private

  def pomodoro_params
    params.require(:pomodoro).permit(:user_id, :task_id)
  end
end

class UserSessionsController < ApplicationController
skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to tasks_path, success: 'ログインしました。'
    else
      render :new
      flash.now[:danger] = 'ログインに失敗しました。'
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました。'
  end
end

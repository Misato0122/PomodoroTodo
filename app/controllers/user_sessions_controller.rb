class UserSessionsController < ApplicationController

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, notice: 'ログインしました。'
    else
      render :new
      flash.now[:alert] = 'ログインに失敗しました。'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'ログアウトしました。'
  end
end
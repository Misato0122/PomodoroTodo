class UsersController < ApplicationController
skip_before_action :require_login, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def show
    @user = current_user
    @data = []
    d = Time.zone.today
    pomodoros = current_user.pomodoros.group("date(created_at)").count
    (0..6).each do |a|
      @data.push([d - a, pomodoros[d - a]])
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: 'ユーザー登録が完了しました。お手数ですがログインをお願い致します。'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

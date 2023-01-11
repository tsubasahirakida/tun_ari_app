class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create new guest_login]
  def new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to posts_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def guest_login
    @guest_user = User.create(
    name: 'ゲスト',
    email: SecureRandom.alphanumeric(10) + "@example.com",
    password: 'password',
    password_confirmation: 'password',
    role: 2
    )
    auto_login(@guest_user)
    redirect_to posts_path, success: 'ゲストとしてログインしました'
  end

  def destroy
    logout
    redirect_to root_path, success: t('.success'), status: :see_other
  end
end

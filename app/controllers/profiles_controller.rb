class ProfilesController < ApplicationController
  #set_user不要
  before_action :set_user, only: %i[edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def my_publishpost
    @posts = current_user.posts.publish.order(created_at: :desc).page(params[:page])
  end

  def my_archivepost
    @posts = current_user.posts.archive.order(created_at: :desc).page(params[:page])
  end

  def my_draftpost
    @posts = current_user.posts.draft.order(created_at: :desc).page(params[:page])
  end

  def my_bookmarkpost
    @posts = current_user.bookmark_posts.order(created_at: :desc).page(params[:page])
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
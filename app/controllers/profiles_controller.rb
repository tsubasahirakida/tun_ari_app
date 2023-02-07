class ProfilesController < ApplicationController
  #set_user不要
  before_action :set_user

  def my_publishpost
    @posts = current_user.posts.publish.order(created_at: :desc).page(params[:page])
  end

  def my_archivepost
    @posts = current_user.posts.archive.order(created_at: :desc)
  end

  def my_draftpost
    @posts = current_user.posts.draft.order(created_at: :desc)
  end

  def my_bookmarkpost
    @posts = current_user.bookmark_posts.order(created_at: :desc)
  end


  private

  def set_user
    @user = User.find(current_user.id)
  end
end
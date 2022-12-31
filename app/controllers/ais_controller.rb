class AisController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.ai(@post)
  end

  def destroy
    @post = current_user.ais.find(params[:id]).post
    current_user.unai(@post)
  end
end
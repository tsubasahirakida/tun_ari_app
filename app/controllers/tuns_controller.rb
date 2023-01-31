class TunsController < ApplicationController
  #find_byに変更
  def create
    @post = Post.find(params[:post_id])
    current_user.tun(@post)
  end

  def destroy
    @post = current_user.tuns.find(params[:id]).post
    current_user.untun(@post)
  end
end

class DeresController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.dere(@post)
  end

  def destroy
    @post = current_user.deres.find(params[:id]).post
    current_user.undere(@post)
  end
end

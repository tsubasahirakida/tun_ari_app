class AisController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    current_user.ai(post)
    redirect_back fallback_location: root_path, success: '愛できました'
  end

  def destroy
    post = current_user.ais.find(params[:id]).post
    current_user.unai(post)
    redirect_back fallback_location: root_path, success: '愛を外しました', status: :see_other
  end
end
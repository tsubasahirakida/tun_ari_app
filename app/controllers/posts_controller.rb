class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @post.character_id = params[:character_id]
    @post.body ||= params[:tempalate_body]
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if params[:commit] == "下書きにする"
      @post.status = 0
    elsif params[:commit] == "非公開にする"
      @post.status = 1
    elsif params[:commit] == "公開する"
      @post.status = 2
    else
      render :new, notice: "statusを選んでください", status: :unprocessable_entity
    end
    @post.post_image = ThumbnailCreator.build(@post.body, @post.character_id)
    if @post.save
      redirect_to post_path(@post), success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post), notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  def character_set
  end

  def template_set
    @templates = PostBodyTemplate.all
    @post = Post.find_or_initialize_by(id: params[:id])
    @post.assign_attributes(post_params)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:character_id, :sendername, :body)
    end
end

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @post.charator_id = params[:charator_id]
    binding.pry
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.post_image = ThumbnailCreator.build(@post.body)
    if @post.save
      redirect_to post_path(@post), notice: "Post was successfully created."
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

  def charactor_set
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:charator_id, :sendername, :body)
    end
end

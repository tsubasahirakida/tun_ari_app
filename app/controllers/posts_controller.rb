class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index]

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
    @post.character_id = params[:character_id]
    @post.body = params[:tempalate_body]
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post.body = params[:tempalate_body] if params[:tempalate_body].present?
  end

  def create
    @post = current_user.posts.new(post_params)
    if params[:commit] == "下書きにする"
      @post.status = 0
    elsif params[:commit] == "非公開にする"
      @post.status = 1
    else 
      @post.status = 2
    end
    @post.post_image = ThumbnailCreator.build(@post.body, @post.character_id)
    if @post.save
      redirect_to post_path(@post), success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def status_update
    @post = Post.find_by(id: params[:id])
    if params[:commit] == "下書きにする"
      @post.status = 0
    elsif params[:commit] == "非公開にする"
      @post.update(status: 1)
    elsif params[:commit] == "公開する"
      @post.status = 2
    else
      render :edit, status: :unprocessable_entity
    end
    if @post.save
      redirect_to post_path(@post), success: t('.success')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def update
    @post.update(post_params)
    @post.post_image = ThumbnailCreator.build(@post.body, @post.character_id)
    if params[:commit] == "下書きにする"
      @post.status = 0
    elsif params[:commit] == "非公開にする"
      @post.status = 1
    elsif params[:commit] == "公開する"
      @post.status = 2
    else
      render :edit, status: :unprocessable_entity
    end
    if @post.save
      redirect_to post_path(@post), success: t('.success')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, success: t('.success'), status: :see_other
  end

  def character_set
  end

  def template_set_new
    @templates = PostBodyTemplate.all
    @post = Post.find_or_initialize_by(id: params[:id])
    @post.assign_attributes(post_params)
  end

  def template_set_edit
    @templates = PostBodyTemplate.all
    @post = Post.find_by(id: params[:post][:id])
    @post.assign_attributes(post_params)
  end

  def ai_boosting
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @posts = Post.includes(:aied_users).
      sort_by {|x|
        x.aied_users.includes(:ais).where(created_at: from...to).size
      }.reverse
  end

  def tundere_boosting
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @posts = Post.includes(:tuned_users, :dered_users).
      sort_by {|x|
        x.tuned_users.includes(:tuns).where(created_at: from...to).size + x.dered_users.includes(:deres).where(created_at: from...to).size
      }.reverse
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:character_id, :sendername, :body, :status, :post_image)
    end
end

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.includes(:user).publish.order(created_at: :desc).page(params[:page])
  end

  def show
    @post = current_user.posts.find_by(id: params[:id])
  end

  def new
    @post = Post.new
    @post.character_id = params[:character_id]
    @post.body = params[:tempalate_body]
    # AI自動生成機能のFormオブジェクトのインスタンス作成
    @generate_ai_modal_form = GenerateAiModalForm.new
  end

  def edit
    @post.body = params[:tempalate_body] if params[:tempalate_body].present?
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.post_image = CardCreator.build(@post.body, @post.character_id)
    set_status(@post)
    if @post.save
      redirect_to post_path(@post), success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def status_update
    @post = Post.find_by(id: params[:id])
    set_status(@post)
    if @post.save
      redirect_to post_path(@post), success: t('.success')
    else
      render :show, status: :unprocessable_entity
    end
  end

  def update
    @post.update(post_params)
    @post.post_image = CardCreator.build(@post.body, @post.character_id)
    set_status(@post)
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
    @templates = PostBodyTemplate.all.order(:created_at)
    @post = Post.find_or_initialize_by(id: params[:id])
    @post.assign_attributes(post_params)
  end

  def template_set_edit
    @templates = PostBodyTemplate.all.order(:created_at)
    @post = Post.find_by(id: params[:post][:id])
    @post.assign_attributes(post_params)
  end

  def ai_boosting
    @posts = Kaminari.paginate_array(Post.ai_boostings).page(params[:page])
  end

  def tundere_boosting
    @posts = Kaminari.paginate_array(Post.tundere_boostings).page(params[:page])
  end

  def download
    @post = Post.find_by(id: params[:id])
    image = @post.post_image
    send_data(image.read,
              filename: "#{@post.body}.png")
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:character_id, :sendername, :body, :status, :post_image)
  end

  def set_status(_post)
    @post.status = if params[:commit] == '下書きにする'
                     0
                   elsif params[:commit] == '非公開にする'
                     1
                   else
                     2
                   end
  end
end

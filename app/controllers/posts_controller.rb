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
  end

  def edit
    @post.body = params[:tempalate_body] if params[:tempalate_body].present?
  end

  def create
    @post = current_user.posts.new(post_params)
    #private下に変更
    @post.status = if params[:commit] == '下書きにする'
                     0
                   elsif params[:commit] == '非公開にする'
                     1
                   else
                     2
                   end
    #ThumbnailCreatorをImageCreatorに変更
    @post.post_image = ThumbnailCreator.build(@post.body, @post.character_id)
    if @post.save
      redirect_to post_path(@post), success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def status_update
    @post = Post.find_by(id: params[:id])
    #private下に変更
    if params[:commit] == '下書きにする'
      @post.status = 0
    elsif params[:commit] == '非公開にする'
      @post.update(status: 1)
    elsif params[:commit] == '公開する'
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
    #ThumbnailCreatorをImageCreatorに変更
    @post.post_image = ThumbnailCreator.build(@post.body, @post.character_id)
    #private下に変更
    if params[:commit] == '下書きにする'
      @post.status = 0
    elsif params[:commit] == '非公開にする'
      @post.status = 1
    elsif params[:commit] == '公開する'
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

  #処理ないこと明示
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
    #modelにscope化
    to = Time.current.at_end_of_day
    from = (to - 6.days).at_beginning_of_day
    @posts = Kaminari.paginate_array(Post.includes(:aied_users).publish
                 .sort_by { |x|
      x.aied_users.includes(:ais).where(ais: {created_at: from...to}).size}.reverse).page(params[:page])
  end
      
  def tundere_boosting
    #modelにscope化
    to = Time.current.at_end_of_day
    from = (to - 6.days).at_beginning_of_day
    @posts = Kaminari.paginate_array(Post.includes(:tuned_users, :dered_users).publish
                 .sort_by { |x|
      x.tuned_users.includes(:tuns).where(tuns: {created_at: from...to}).size + x.dered_users.includes(:deres).where(deres: {created_at: from...to}).size}.reverse).page(params[:page])
  end

  def download
    #find_byに変更
    @post = Post.find(params[:id])
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
end

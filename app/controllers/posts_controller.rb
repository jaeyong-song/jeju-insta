class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  # before_action :is_writer, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  # GET /posts
  # GET /posts.json
  def index
    if params.has_key?(:content)
      @posts = Post.where('content like ?', "%#{params[:content]}%")
      # rails activerecord query(google)
      # 모델 메소드
      # 1. all
      # 2. find(:id)
      # 3. find([:id, :id])
      # 4. where
      # 5. where.not
      # 6. order()
      #   ex. Post.all.order(created_at: :desc / :asc)
      # 7. first(n)
      #   ex. Post.order(created_at: :desc).first(n)
      # 8. last(n)
      #   ex. Post.order(created_at: :asc).last(n)
      # 9. limit(n) - order()와 함께 사용
      
    else
      @posts = Post.where(user_id: current_user.followees.ids.push(current_user.id))
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)
    # @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def mypage
    @posts = current_user.posts
  end
  
  # POST 'posts/:id/like'
  def like
    @post.toggle_like(current_user)
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:image, :content)
    end
    
    # auth for writer
    # def is_writer
    #   if @post.user != current_user
    #     redirect_to "/posts", notice: '수정 및 삭제 권한이 없습니다.'
    #   end
    # end
end
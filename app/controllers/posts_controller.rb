class PostsController < ApplicationController
  before_action :require_logged_in, only: [:create, :new, :edit, :update, :destroy]
  before_action :require_current_user_owns_post, only: [:edit, :update]
  before_action :require_current_user_owns_post_or_subforum, only: [:destroy]

  def create
    @post = current_user.posts.new(post_params)
    @post.subforum_id = params[:subforum_id]
    @subforum = @post.subforum

    if @post.save
      redirect_to subforum_post_url(@post.subforum_id, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def new
    @post = Post.new
    @subforum = Subforum.find_by(id: params[:subforum_id])
  end

  def edit
    @post = Post.find(params[:id])
    @subforum = Subforum.find_by(id: params[:subforum_id])
    debugger
  end

  def show
    @post = Post.find(params[:id])
    @subforum = Subforum.find_by(id: params[:subforum_id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to subforum_post_url(@post.subforum_id, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to subforum_url(@post.subforum)
  end

  private

  def require_current_user_owns_post
    return if current_user.posts.find_by(id: params[:id])
    @post = Post.find(params[:id])
    flash[:errors] = ["You are not the creator of this post"]
    redirect_to subforum_post_url(@post.subforum_id, @post)
  end

  def require_current_user_owns_post_or_subforum
    return if (
    current_user.subforums.find_by(id: params[:subforum_id]) || current_user.posts.find_by(id: params[:id])
    )
    @post = Post.find(params[:id])
    flash[:errors] = ["You are not the post's creator or subforum's moderator"]
    redirect_to subforum_post_url(@post.subforum_id, @post)
  end

  def post_params
    params.require(:post).permit(:title, :url, :body)
  end
end

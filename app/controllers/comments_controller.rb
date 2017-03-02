class CommentsController < ApplicationController
  before_action :require_logged_in, :only: [:create, :new, :edit, :update, :destroy]
  before_action :require_current_user_owns_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    @post = @comment.post
    @subforum = @comment.subforum

    if @comment.save
      redirect_to subforum_post_comment_url(@subforum, @comment.post_id, @comment)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def new
    @comment = Comment.new
    @post = Post.find_by(id: params[:post_id])
    @subforum = Subforum.find_by(id: params[:subforum_id])
  end

  def edit
    @comment = Comment.new
    @post = Post.find_by(id: params[:post_id])
    @subforum = Subforum.find_by(id: params[:subforum_id])
  end

  def show
    @comment = Comment.new
    @post = Post.find_by(id: params[:post_id])
    @subforum = Subforum.find_by(id: params[:subforum_id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to subforum_post_comment_url(params[:subforum_id], @comment.post_id, @comment)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :edit
    end
  end

  def destroy
    @comment = Comment.find[params[:id]]
    @comment.delete
    redirect_to subforum_post_url(params[:subforum_id], @comment.post_id)
  end

  private

  def require_current_user_owns_comment
    return if current_user.comments.find_by(id: params[:id])
    @comment = Comment.find(params[:id])
    flash[:errors] = ["You did not make this comment"]
    redirect_to subforum_post_comment_url(params[:subforum_id], @comment.post_id, @comment)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
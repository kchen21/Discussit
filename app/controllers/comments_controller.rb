class CommentsController < ApplicationController
  before_action :require_logged_in, only: [:create, :new, :edit, :update, :destroy]
  before_action :require_current_user_owns_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    @post = @comment.post
    @subforum = @comment.subforum

    if @comment.save
      redirect_to subforum_post_url(@subforum, @comment.post_id)
    else
      if @comment.parent_comment_id
        flash[:errors] = @comment.errors.full_messages
        redirect_to subforum_post_comment_url(@subforum, @comment.post_id, @comment.parent_comment_id)
      else
        flash.now[:errors] = @comment.errors.full_messages
        render :new
      end
    end
  end

  def new
    @comment = Comment.new
    @post = Post.find_by(id: params[:post_id])
    @subforum = Subforum.find_by(id: params[:subforum_id])
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @subforum = @comment.subforum
  end

  def show
    @comment = Comment.find(params[:id])
    @child_comments = @comment.child_comments

    @post = @comment.post
    @subforum = @comment.subforum

    @child_comment = @comment.child_comments.new
  end

  def update
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @subforum = @comment.subforum

    if @comment.update(comment_params)
      redirect_to subforum_post_comment_url(params[:subforum_id], @comment.post_id, @comment)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    redirect_to subforum_post_url(params[:subforum_id], @comment.post_id)
  end

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  private

  def require_current_user_owns_comment
    return if current_user.comments.find_by(id: params[:id])
    @comment = Comment.find(params[:id])
    flash[:errors] = ["You did not make this comment"]
    redirect_to subforum_post_comment_url(params[:subforum_id], @comment.post_id, @comment)
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_comment_id)
  end

  def vote(value)
    @comment = Comment.find(params[:id])
    @subforum = @comment.subforum
    @vote = @comment.votes.find_or_initialize_by(user: current_user)

    unless @vote.update(value: value)
      flash[:errors] = @vote.errors.full_messages
    end

    redirect_to subforum_post_url(@subforum, @comment.post_id)
  end
end

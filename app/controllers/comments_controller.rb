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
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def require_current_user_owns_comment
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end

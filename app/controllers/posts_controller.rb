class PostsController < ApplicationController
  before_action :require_logged_in, only: [:create, :new, :edit, :update, :destroy]
  before_action :require_current_user_owns_post, only: [:edit, :update]
  before_action :require_current_user_or_moderator_owns_post, only: [:destroy]

  private

  def require_current_user_owns_post
    return if current_user.posts.find_by(id: params[:id])
    @post = Post.find(params[:id])
    flash[:errors] = ["You are not the creator of this post"]
    redirect_to post_url(@post)
  end
end

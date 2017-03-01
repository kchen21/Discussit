class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, only: [:destroy]

  def new
  end

  def create
    user = User.find_by_credentials(
    params[:user][:username],
    params[:user][:password])

    if user
      log_in(user)
      redirect_to subforums_url
    else
      flash.now[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end
end

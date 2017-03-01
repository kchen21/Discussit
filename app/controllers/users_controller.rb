class UsersController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  before_action :require_logged_in, only: [:show, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      redirect_to subforums_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to subforums_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
  end
end

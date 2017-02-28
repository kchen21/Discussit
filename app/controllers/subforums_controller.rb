def SubforumsController < ApplicationController
  before_action :require_logged_in, only: [:create, :new, :edit, :update, :destroy]
  before_action :require_current_user_owns_subforum, only: [:edit, :update, :destroy]

  def index
    @subforums = Subforum.all
  end

  def create
    @subforum = current_user.subforums.new(subforum_params)


    if @subforum.save
      redirect_to subforum_url(@subforum)
    else
      flash.now[:errors] = @subforum.errors.full_messages
      render :new
    end
  end

  def new
    @subforum = Subforum.new
  end

  def edit
    @subforum = Subforum.find(params[:id])
  end

  def show
    @subforum = Subforum.find(params[:id])
  end

  def update
    @subforum = Subforum.find(params[:id])

    if @subforum.update(subforum_params)
      redirect_to subforum_url(@subforum)
    else
      flash.now[:errors] = @subforum.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  private

  def require_current_user_owns_subforum
    return if current_user.subforums.find_by(id: params[:id])
    @subforum = Subforum.find(params[:id])
    flash[:errors] = ["You are not the creator of this subforum"]
    redirect_to subforum_url(@subforum)
  end

  def subforum_params
    params.require(:subforum).permit(:title, :description)
  end
end

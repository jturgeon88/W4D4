class UsersController < ApplicationController

  def new
    @user = User.new
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user.id)
    else
      flash.now[:error] = @user.errors.full_messages
      render new_users_url
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    render json: @user
  end

  # def edit
  #   @user = User.find_by_id(params[:id])
  # end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end

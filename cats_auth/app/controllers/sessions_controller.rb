class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to root_url
    else
      render :new
    end
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      log_in!(user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Invalid login"]
      render :new
    end
  end

  def destroy
    if logged_in?
      log_out!
      redirect_to root_url
    else
      flash.now[:errors] = ["Must be logged in to log out"]
      render new_session_url
    end
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end

end

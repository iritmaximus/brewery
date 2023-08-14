class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]

    if user&.authenticate(params[:password])
      session[:user_id] = user.id if user
      redirect_to user_path user, notice: "Welcome back :)"
    else
      redirect_to signin_path, notice: "Incorrect username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    result = Users::AuthenticateCommand.execute(params[:email], params[:password])

    if result[:success]
      user = result[:user]
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome back, #{user.full_name}!"
    else
      flash[:error] = result[:errors].first
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully logged out!"
  end
end

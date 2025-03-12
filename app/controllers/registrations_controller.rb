class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    result = Users::RegisterCommand.execute(user_params)

    if result[:success]
      @user = result[:user]
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created successfully!"
    else
      @user = User.new(user_params)
      @user.errors.add(:base, result[:errors])
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :email, :password,
                               :password_confirmation, :contact_address)
  end
end

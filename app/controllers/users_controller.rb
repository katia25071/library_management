class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [ :edit, :update ]
  before_action :ensure_correct_user, only: [ :edit, :update ]
  before_action :require_library_personnel, only: [ :index, :search ]

  def index
    result = Users::SearchCommand.execute(params[:search])
    @users = result[:users]
  end

  def edit
  end

  def update
    result = Users::UpdateCommand.execute(@user, user_params_without_email)

    if result[:success]
      redirect_to root_path, notice: "Profile updated successfully!"
    else
      @user.errors.add(:base, result[:errors])
      render :edit
    end
  end

  def search
    result = Users::SearchCommand.execute(params[:term])
    @users = result[:users]
    render :index
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params_without_email
    params.require(:user).permit(:name, :surname, :contact_address)
  end

  def ensure_correct_user
    unless @user == current_user || current_user.library_personnel?
      redirect_to root_path, alert: "You can only edit your own profile"
    end
  end
end

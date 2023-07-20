class ProfilesController < ApplicationController
  before_action :set_user,only: %i[edit update]
  def show
    @user = current_user
  end

  def edit;end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'プロフィールを更新しました'
    else
      render :edit
    end
  end

  private
  def set_user
      @user = User.find(current_user.id)
  end

  def user_params
      params.require(:user).permit(:email,:first_name,:last_name,:avatar,:avatar_cashe)
  end
end

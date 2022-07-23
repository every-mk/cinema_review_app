class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    if current_user.email == GUEST_USER_EMAIL
      flash[:alert] = "ゲストユーザーはプロファイルを編集できません"
      render "show"
    elsif current_user.profile.update(profile_update_params)
      flash[:notice] = "プロファイル更新しました"
      redirect_to profile_path
    else
      render "show"
    end
  end

  private

  def profile_update_params
    params.require(:profile).permit(:name, :sex, :date_of_birth, :prefecture, :municipality, :image)
  end
end

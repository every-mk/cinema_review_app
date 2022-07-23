class UsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :authenticate_user!, only: [:account]

  # ToDo: cinema#indexの代替アクション
  def index
  end

  def destroy
    if current_user.email == GUEST_USER_EMAIL
      flash[:alert] = "ゲストユーザーは削除できません"
      render "account"
    elsif current_user.destroy
      flash[:notice] = "アカウントを削除しました"
      redirect_to root_path
    else
      render "account"
    end
  end

  def guest_sign_in
    password = SecureRandom.urlsafe_base64
    user = User.find_or_initialize_by(email: GUEST_USER_EMAIL) do |u|
      u.password = password
      u.password_confirmation = password
      u.confirmed_at = Time.now
    end

    user.build_profile(name: "ゲストユーザー", sex: 0, date_of_birth: Time.now, prefecture: "沖縄県", municipality: "那覇市")
    user.save
    user.profile.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'profile', 'default_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')

    sign_in user
    redirect_to root_path
    flash[:notice] = "ログインしました。"
  end

  def account
  end
end

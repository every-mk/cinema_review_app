class AdminsController < ApplicationController
  before_action :authenticate_admin!, only: [:index]

  def index
  end

  def guest_sign_in
    password = SecureRandom.urlsafe_base64
    guest_admin = Admin.find_or_create_by!(email: GUEST_EMAIL) do |admin|
      admin.password = password
      admin.password_confirmation = password
    end

    sign_in guest_admin
    redirect_to admins_path
    flash[:notice] = "ログインしました。"
  end
end

class UsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :authenticate_user!, only: [:account]
  
  # ToDo: cinema#indexの代替アクション
  def index
  end

  def destroy
    if current_user.destroy
      flash[:notice] = "アカウントを削除しました"
      redirect_to root_path
    else
      render "account"
    end
  end
  
  def account
  end
end

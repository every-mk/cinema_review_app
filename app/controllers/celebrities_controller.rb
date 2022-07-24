class CelebritiesController < ApplicationController
  before_action :set_celebrity, only: [:show, :edit, :update, :destroy]

  def new
    @celebrity = Celebrity.new
  end

  def create
    @celebrity = Celebrity.new(celebrity_params)

    if @celebrity.save
      flash[:notice] = "著名人を作成しました"
      redirect_to admins_path
    else
      flash[:errors_full_messages] = @celebrity.errors.full_messages
      render "new"
    end
  end

  def edit
  end

  def update
    if @celebrity.update(celebrity_params)
      flash[:notice] = "著名人を更新しました"
      redirect_to admins_path
    else
      flash[:errors_full_messages] = @celebrity.errors.full_messages
      render "edit"
    end
  end

  def show
  end

  def destroy
    if current_admin.email == GUEST_EMAIL
      flash[:alert] = "ゲストユーザーは削除権限がありません"
      render "edit"
    elsif @celebrity.destroy
      flash[:notice] = "著名人を削除しました"
      redirect_to admins_path
    else
      render "edit"
    end
  end

  private

  def set_celebrity
    @celebrity = Celebrity.find(params[:id])
  end

  def celebrity_params
    params.require(:celebrity).permit(:name, :ruby, :date_of_birth, :birthplace, :history, :image)
  end

  # def create_default_celebrity_image
  #   @celebrity.image.attach()
  # end
end

class CinemasController < ApplicationController
  before_action :set_cinema, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @cinema = Cinema.new
  end

  def create
    @cinema = Cinema.new(cinema_params)

    if @cinema.save
      flash[:notice] = "映画を作成しました"
      redirect_to admins_path
    else
      flash[:errors_full_messages] = @cinema.errors.full_messages
      render "new"
    end
  end

  def edit
  end

  def update
    if @cinema.update(cinema_params)
      flash[:notice] = "映画を更新しました"
      redirect_to admins_path
    else
      flash[:errors_full_messages] = @cinema.errors.full_messages
      render "edit"
    end
  end

  def show
    # @review = Review.find_or_initialize_by(user_id: current_user.id, cinema_id: @cinema.id)
  end

  def destroy
    if current_admin.email == GUEST_EMAIL
      flash[:alert] = "ゲストユーザーは削除権限がありません"
      render "edit"
    elsif @cinema.destroy
      flash[:notice] = "映画を削除しました"
      redirect_to admins_path
    else
      render "edit"
    end
  end

  private

  def set_cinema
    @cinema = Cinema.find(params[:id])
  end

  def cinema_params
    params.require(:cinema).permit(:title, :screen_time, :birthplace, :movie_rating, :director, :original, :appearance, :screenwriter, :distribution, :start_date, :story, :image)
  end
end

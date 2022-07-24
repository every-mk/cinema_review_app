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
  end

  def show
  end

  def destroy
  end

  private

  def set_cinema
    @cinema = Cinema.find(params[:id])
  end

  def cinema_params
    params.require(:cinema).permit(:title, :screen_time, :birthplace, :movie_rating, :director, :original, :appearance, :screenwriter, :distribution, :start_date, :story, :image)
  end
end

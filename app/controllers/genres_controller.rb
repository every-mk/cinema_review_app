class GenresController < ApplicationController
  before_action :set_genre, only: [:edit, :update, :destroy]

  def index
    @genres = Genre.all
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      flash[:notice] = "ジャンルを作成しました"
      redirect_to genres_path
    else
      flash[:errors_full_messages] = @genre.errors.full_messages
      render "new"
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      flash[:notice] = "ジャンル名を更新しました"
      redirect_to genres_path
    else
      flash[:errors_full_messages] = @genre.errors.full_messages
      render "edit"
    end
  end

  def show
  end

  def destroy
    if current_admin.email == GUEST_EMAIL
      flash[:alert] = "ゲストユーザーは削除権限がありません"
      render "edit"
    elsif @genre.destroy
      flash[:notice] = "ジャンル名を削除しました"
      redirect_to genres_path
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end

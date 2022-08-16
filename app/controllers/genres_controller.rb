class GenresController < ApplicationController
  def index
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
  end

  def show
  end

  def destroy
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end

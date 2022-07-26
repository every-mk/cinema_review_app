class ReviewsController < ApplicationController
  def new
    @review = Review.new(after_watch: 0)
    @cinema_id = params[:cinema_id]
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:notice] = "レビューを作成しました"
      redirect_to root_path
    else
      flash[:errors_full_messages] = @review.errors.full_messages
      render "new"
    end
  end

  def edit
  end

  def update
  end

  private

  def review_params
    params.require(:review).permit(:recommendation, :after_watch, :spoiler, :content, :user_id, :cinema_id)
  end
end

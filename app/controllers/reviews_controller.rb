class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update]

  def new
    @review = Review.new(after_watch: 0)
    @cinema_id = params[:cinema_id]
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      flash[:notice] = "レビューを作成しました"
      redirect_to cinema_path(@review.cinema_id)
    else
      flash[:errors_full_messages] = @review.errors.full_messages
      render "new"
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:notice] = "レビューを更新しました"
      redirect_to cinema_path(@review.cinema_id)
    else
      flash[:errors_full_messages] = @review.errors.full_messages
      render "edit"
    end
  end

  private

  def set_review
    @review = Review.find_by(id: params[:id], user_id: current_user.id)
  end

  def review_params
    params.require(:review).permit(:recommendation, :after_watch, :spoiler, :content, :user_id, :cinema_id)
  end
end

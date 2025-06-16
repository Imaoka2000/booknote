class ReviewsController < ApplicationController
  before_action :authenticate_user!
  include OpenbdHelper
  def index
    @reviews = Review.includes(:user).order(created_at: :desc)
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to reviews_path, notice: "投稿しました"
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    @book = fetch_book_info(@review.isbn)
  end

  private

  def review_params
    params.require(:review).permit(:isbn, :content)
  end
end

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  include OpenbdHelper
  def index
    @reviews = Review.includes(:user).order(created_at: :desc)
  end

  def show
    @review = Review.find(params[:id])
    @book = fetch_book_info(@review.isbn)
  end
  def new
    @review = Review.new
  end

  def edit
    @review = Review.find(params[:id])
  end
  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to reviews_path, notice: "投稿しました"
    else
      render :new
    end
  end


  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to review_path(@review), notice: "レビューを更新しました。"
  end


  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path, notice: "レビューを削除しました"
  end

  private

  def review_params
    params.expect(review: [:isbn, :content])
  end
end

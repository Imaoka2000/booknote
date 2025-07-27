# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: %i[edit update destroy]

  def new
    @review = Review.new
  end

  def edit
    session[:previous_url] = request.referer
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to book_path(@review.isbn), notice: "投稿しました"
    else
      render :new
    end
  end

  def update
    if @review.update(review_params)
      redirect_to session[:previous_url], notice: "レビューを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_back fallback_location: root_path, notice: "レビューを更新しました"
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.expect(review: %i[isbn content])
  end
end

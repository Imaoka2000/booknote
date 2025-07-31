# frozen_string_literal: true

class ReviewLikesController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @review_like = current_user.review_likes.new(review: @review)

    if @review_like.save
      redirect_to @review
    else
      redirect_to @review, alert: "いいねに失敗しました。"
    end
  end

  def destroy
    @review_like = current_user.review_likes.find_by(review_id: params[:review_id])

    if @review_like
      @review_like.destroy
      redirect_to Review.find(params[:review_id])
    else
      redirect_to Review.find(params[:review_id]), alert: "いいねの取り消しに失敗しました。"
    end
  end
end

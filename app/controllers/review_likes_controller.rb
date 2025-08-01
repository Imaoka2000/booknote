# frozen_string_literal: true

class ReviewLikesController < ApplicationController
  def toggle
    @review = Review.find(params[:review_id])
    @review_like = current_user.review_likes.find_by(review: @review)

    if @review_like
      @review_like.destroy
    else
      current_user.review_likes.create(review: @review)
    end

    @review.reload

    respond_to do |format|
      format.html { redirect_to @review }
      format.turbo_stream
    end
  end
end

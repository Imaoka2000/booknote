# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.order(created_at: :desc)
    @book_infos = @reviews.to_h do |review|
      [ review.isbn, BookInfoFetcher.fetch(review.isbn) ]
    end
  end

  private

  def user_params
    params.expect(user: %i[password password_confirmation profile_image])
  end
end

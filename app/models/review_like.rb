# frozen_string_literal: true

class ReviewLike < ApplicationRecord
  belongs_to :user
  belongs_to :review
end

# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  validates :isbn, presence: true
  validates :content, presence: true
end

# frozen_string_literal: true

class Book < ApplicationRecord
  validates :isbn, presence: true, uniqueness: true
end

class Review < ApplicationRecord
  belongs_to :user
  validates :isbn, presence: true
  validates :content, presence: true
end

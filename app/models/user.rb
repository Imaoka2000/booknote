# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :review_likes, dependent: :destroy
  has_many :followers, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followeds, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_one_attached :profile_image
end

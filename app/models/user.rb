class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :posts, dependent: :destroy
  has_many :public_posts, ->{ where(state: "public") },class_name: "Post"
  has_many :draft_posts, ->{ where(state: "draft") },class_name: "Post"

  has_many :replies, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects, source: "post"

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  
  
end

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

  
end

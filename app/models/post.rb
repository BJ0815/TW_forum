class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  mount_uploader :photo, PhotoUploader

  validates :title, presence: true
  validates :description, presence: true, length: { maximum: 150 }
  validates :article_role, presence: true
  validates :category_id, presence:true
end

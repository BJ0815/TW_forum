class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :replies, dependent: :destroy
  has_many :collects, dependent: :destroy

  mount_uploader :photo, PhotoUploader

  validates :title, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :article_role, presence: true
  validates :state, presence: true
end

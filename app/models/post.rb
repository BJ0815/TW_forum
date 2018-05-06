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

  scope :publics, -> { where(state: "public") }

  def self.article_role(user)
    # 根據文章權限顯示
    if user
      where(article_role: "all").or( where(article_role: "friend", user: [user.friends, user])).or( where(article_role: "myself", user: user))
    else
      where(article_role: "all").publics.includes(:replies)
    end
  end
end

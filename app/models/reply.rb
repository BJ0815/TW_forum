class Reply < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true

  validates :user, presence: true
  validates :post, presence: true
end

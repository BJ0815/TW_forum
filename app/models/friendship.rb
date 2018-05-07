class Friendship < ApplicationRecord
  after_create :created_inverse_relationship
  after_destroy :destroy_inverse_relationship

  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  # 自訂驗證
  validate :not_self # 不能加自己好友

  private

  def not_self
    errors[:friend] << "can't be equal to user" if user == friend
  end

  def created_inverse_relationship
    friend.friendships.create(friend: user)
  end

  def destroy_inverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end
end

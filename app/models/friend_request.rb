class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_self
  validate :not_friends

  def accept
    user.friends << friend
    destroy
  end

  private

  def not_self
    errors[:friend] << "can't be equal to user" if user == friend
  end

  def not_friends
    errors[:friend] << "is already added" if user.friends.include?(friend)
  end
end
class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  # 自訂驗證
  validate :not_self # 不能加自己好友
  validate :not_friends # 已經是好友就不能重複邀請
  validate :not_pending # 已經在等待邀請的好友不能重複邀請

  def accept
    # 接受好友邀請
    user.friends << friend # 藉由friendship關聯新增friend
    destroy # 並將好友邀請刪除
  end

  private

  def not_self
    errors[:friend] << "can't be equal to user" if user == friend
  end

  def not_friends
    errors[:friend] << "is already added" if user.friends.include?(friend)
  end

  def not_pending
    errors[:friend] << 'already requested friendship' if friend.pending_friends.include?(user)
  end
end

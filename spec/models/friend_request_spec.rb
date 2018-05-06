require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'Association' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  # describe 'Validation' do
  #   subject { FactoryBot.create(:friend_request) }
  #   it { should validate_presence_of(:user) }
  #   it { validate_uniqueness_of(:friend_id).scoped_to(:user_id) }
  # end
end
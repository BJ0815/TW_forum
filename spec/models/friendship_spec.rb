require 'rails_helper'

RSpec.describe Friendship, type: :model do

  describe 'Association' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end

  describe 'Validation' do 
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:friend) } 
    it { validate_uniqueness_of(:friend_id).scoped_to(:user_id) }
  end
end
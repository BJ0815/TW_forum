require 'rails_helper'

RSpec.describe Reply, type: :model do

  describe 'Association' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'Validation' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:post) }
  end
  
end
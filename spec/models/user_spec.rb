require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Association" do
    it { should have_many(:posts) }
    it { should have_many(:replies) }
    it { should have_many(:collects) }
    it { should have_many(:friendships) }
    it { should have_many(:friend_requests) }
  end

  describe "Validation" do
    subject { FactoryBot.create(:user) }
    it { should validate_uniqueness_of(:name) }
  end

  it "should count all user" do
    expect(User.all.count).to eq(0)
    create(:user)
    expect(User.all.count).to eq(1)
  end

  it "should count all posts by this user" do
    user = create(:user)
    expect(user.posts.count).to eq(0)
    post = create(:post)
    user.posts << post
    expect(user.posts.count).to eq(1)
  end

end

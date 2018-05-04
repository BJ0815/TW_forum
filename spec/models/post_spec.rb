require 'rails_helper'

RSpec.describe Post, type: :model do
  
  describe "Association" do
    it { should have_many(:replies) }
    it { should belong_to(:user) }
    it { should have_many(:collects) }
    it { should have_and_belong_to_many(:categories) }
  end

  describe "Validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:article_role) }
    it { should validate_presence_of(:state) }
  end

end
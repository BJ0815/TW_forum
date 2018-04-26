require 'rails_helper'

RSpec.describe User, type: :model do
  it "should count all user" do
    expect(User.all.count).to eq(0)
    create(:user)
    expect(User.all.count).to eq(1)
  end

end

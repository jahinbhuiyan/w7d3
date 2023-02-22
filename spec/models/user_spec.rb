require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:session_token)}
  it {should validate_length_of(:password).is_at_least(6)}
  it {should allow_value(nil).for(:password)}
  

  it {should have_many(:goals)}

  describe "User::find_by_credentials" do
    it "should find the correct user" do
      params = {username: "zahin", password: "password"}
      user1 = User.create(params)
      expect(User.find_by_credentials(params[:username], params[:password])).to eq(user1) 
    end
  end
end

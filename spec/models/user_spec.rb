require 'rails_helper'

RSpec.describe User, type: :model do
  it "has username set correctly" do
    user = User.new username: "Möötti"
    User.all.each do |user| puts user.username end
    expect(user.username).to eq "Möötti"
    expect(User.count).to eq 0
  end

  it "is not saved without a password" do
    user = User.create username: "Pööpi"
    expect(user).not_to be_valid
    expect(User.count).to eq 0
  end

  it "is saved with a proper password" do
    user = User.create username: "Möötti", password: "Unsecure1"
    expect(user).to be_valid
    expect(User.count).to eq 1
  end

  it "is not saved with a password without uppercase or too short length" do
    userMöötti = User.create username: "Möötti", password: "unsecure"
    userMaatti = User.create username: "Maatti", password: "u"

    expect(userMöötti).to_not be_valid
    expect(userMaatti).to_not be_valid
  end
end

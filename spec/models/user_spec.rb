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

  describe "favourite_style" do
    let(:user) { FactoryBot.create(:user) }
    let(:brewery) { FactoryBot.create(:brewery) }
    let(:style) { FactoryBot.create(:style) }

    it "is defined method" do
      expect(user).to respond_to(:favorite_style)
    end

    it "returns a string" do
      expect(user.favorite_style).to be_a(String)
    end

    it "returns the most liked style" do
      create_beer_with_many_ratings({user: user, brewery: brewery, style: style.id}, 10, 10, 20)
      beer_with_favorite_style = FactoryBot.create :beer, style_id: style.id
      FactoryBot.create(:rating, beer: beer_with_favorite_style, score: 50, user: user)

      expect(user.favorite_style).to eq "Yes"
    end

    it "also returns the most liked style" do
      other_style = Style.create name: "No"
      create_beer_with_many_ratings({user: user, brewery: brewery, style: style.id}, 20, 30, 20)
      beer_with_favorite_style = FactoryBot.create(:beer, style_id: other_style.id)
      FactoryBot.create(:rating, beer: beer_with_favorite_style, score: 50, user: user)

      expect(user.favorite_style).to eq "Yes"
    end
  end

  describe "favorite_brewery" do
    let(:user){ FactoryBot.create(:user) }
    let(:brewery1){ FactoryBot.create(:brewery) }
    let(:brewery2){ FactoryBot.create(:brewery, name: "Boring") }
    let(:style) { FactoryBot.create(:style) }
    before do create_beer_with_many_ratings({user: user, brewery: brewery1, style: style.id}, 20, 30, 20, 40) end
    before do create_beer_with_many_ratings({user: user, brewery: brewery2, style: style.id}, 20, 30, 20, 50) end

    it "is a defined method" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "returns a string" do
      expect(user.favorite_brewery).to be_a(String)
    end
    it "returns the correct brewery" do
      expect(user.favorite_brewery).to eq "Boring"
    end
  end
end

def create_beer_with_rating(object, score)
  beer = FactoryBot.create(:beer, brewery: object[:brewery], style_id: object[:style])
  rating = FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
end

def create_beer_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end

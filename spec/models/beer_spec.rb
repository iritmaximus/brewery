require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe "creation" do
    let(:user) { User.create username: "Möötti", password: "Unsecure1"}
    let(:brewery) { Brewery.create name: "Creative", year: 2023 }
    let(:style) { FactoryBot.create :style }

    it "is successful with correct parameters" do
      beer = Beer.create name: "Hyvä juoma", style_id: style.id, brewery_id: brewery.id
      expect(beer).to be_valid
      expect(beer.name).to eq "Hyvä juoma"
      expect(beer.style_id).to eq style.id
      expect(beer.brewery_id).to eq brewery.id
    end

    it "fails if no name is given" do
      beer = Beer.create style_id: style.id, brewery_id: brewery.id
      expect(beer).to_not be_valid
    end

    it "fails if no style is given" do
      beer = Beer.create name: "Möötti", brewery_id: brewery.id
      expect(beer).to_not be_valid
    end
  end
end

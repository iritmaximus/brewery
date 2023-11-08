require "rails_helper"

describe "Breweries page" do
  it "should not have any before created" do
    visit breweries_path
    expect(page).to have_content "Breweries"
    # Has all of the default Breweries
    expect(Brewery.count).to eq 3
  end
end

require "rails_helper"

describe "Ratings Page" do
  it "should not contain anything in the beginning" do
    visit ratings_path
    expect(page).to have_content "List of ratings"
    expect(page).to have_content "There is 0 ratings"

    FactoryBot.create :rating

    visit ratings_path
    expect(page).to have_content "There is 1 rating"
  end
end

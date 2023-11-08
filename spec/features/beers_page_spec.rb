require "rails_helper"

describe "Beers page" do
  it "should display all beers in the database" do
    visit beers_path
    expect(page).to have_content "Beers"
    expect(page).to have_content "Iso 3"
    expect(page).to have_content "Karhu"
    expect(page).to have_content "Tuplahumala"
    expect(page).to have_content "Huvila Pale Ale"
    expect(page).to have_content "X Porter"
    expect(page).to have_content "Hefeweizen"
    expect(page).to have_content "Helles"
  end

  it "should be able to add a new beer" do
    visit new_beer_path
    expect(page).to have_content "New beer"
    expect(page).to_not have_content "New fancy test beer"

    fill_in("beer_name", with: "New fancy test beer")
    click_button "Create Beer"

    expect(page).to have_content "Beer was successfully created"
    expect(page).to have_content "New fancy test beer"
  end

  it "should not be able to add a new beer without a proper beer name" do
    visit new_beer_path
    expect(page).to have_content "New beer"
    expect(page).to_not have_content "New fancy test beer"

    fill_in("beer_name", with: "")
    click_button "Create Beer"
    
    expect(page).to_not have_content "Beer was successfully created"
    expect(page).to_not have_content "New fancy test beer"

    expect(page).to have_content "Name can't be blank"
  end
end

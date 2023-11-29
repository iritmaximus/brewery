require "rails_helper"

describe "Beers page" do
  let(:user) { FactoryBot.create :user }
  let(:brewery){ FactoryBot.create :brewery }
  let(:style) { FactoryBot.create :style }
  let(:beer){ FactoryBot.create :beer, brewery: brewery, style_id: style.id }

  it "should be empty before tests" do
    visit beers_path
    expect(page).to have_content "Beers"

    expect(page).to_not have_content "Iso 3"
    expect(page).to_not have_content "Something good"
    expect(Beer.all.count).to be_equal(0)
  end

  it "should display all beers in the database" do
    brewery.save()
    style.save()
    beer.save()

    visit beers_path
    expect(page).to have_content "Beers"
    expect(page).to have_content "Something good"

  end

  it "should be able to add a new beer" do
    user.save()
    style.save()
    brewery.save()

    visit new_session_path
    fill_in "username", with: "MööttiTesti"
    fill_in "password", with: "Unsecure1"
    click_button "Log in"

    visit new_beer_path
    expect(page).to have_content "New beer"
    expect(page).to_not have_content "New fancy test beer"

    fill_in("beer_name", with: "New fancy test beer")
    click_button "Create Beer"

    expect(page).to have_content "Beer was successfully created"
    expect(page).to have_content "New fancy test beer"
    expect(Beer.find_by(name: "New fancy test beer").nil?).to be_equal(false)
  end

  it "should not be able to add a new beer without a proper beer name" do
    user.save()

    visit new_session_path
    fill_in "username", with: "MööttiTesti"
    fill_in "password", with: "Unsecure1"
    click_button "Log in"

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

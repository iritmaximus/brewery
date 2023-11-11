require "rails_helper"

describe "User Page" do
  let(:user) { FactoryBot.create :user }
  let(:brewery) { FactoryBot.create :brewery }
  let(:beer) { FactoryBot.create :beer }
  let(:rating1) { Rating.create score: 20, user_id: user.id, beer_id: beer.id }
  let(:rating2) { Rating.create score: 30, user_id: user.id, beer_id: beer.id }

  it "should display only user's ratings" do
    # this took over an hour to remember to do... :D
    user.save()
    brewery.save()
    beer.save()
    rating1.save()
    rating2.save()

    visit user_path(user.id)

    expect(page).to have_content "Username: MööttiTesti"
    expect(page).to have_content "Has made 2 ratings"

    expect(page).to have_content "Something good 20"
    expect(page).to have_content "Something good 30"
  end

  it "before login doesn't show Delete button" do
    user.save()
    rating1.save()
    rating2.save()

    visit user_path(user.id)
    expect(page).to_not have_content "Delete"
  end

  it "after login shows Delete button" do
    user.save()
    rating1.save()
    rating2.save()

    #login
    visit new_session_path
    fill_in "username", with: "MööttiTesti"
    fill_in "password", with: "Unsecure1"
    click_button "Log in"

    visit user_path(user.id)
    expect(page).to have_content "Delete"
  end

  it "should on rating delete also delete the rating from the database" do
    rating1.save()
    rating2.save()

    expect(Rating.all.count).to be_equal 2

    # login
    visit new_session_path
    fill_in "username", with: "MööttiTesti"
    fill_in "password", with: "Unsecure1"
    click_button "Log in"

    visit user_path(user)
    page.first(:link, "Delete").click()

    expect(page).to_not have_content "Iso 3 20"
    expect(Rating.all.count).to be_equal 1
  end
end

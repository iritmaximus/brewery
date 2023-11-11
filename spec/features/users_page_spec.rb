require "rails_helper"

describe "User Page" do
  let(:user) { FactoryBot.create :user }
  let(:rating1) { Rating.create score: 20, user_id: user.id, beer_id: Beer.first.id }
  let(:rating2) { Rating.create score: 30, user_id: user.id, beer_id: Beer.first.id }

  it "should display only user's ratings" do
    # this took over an hour to remember to do... :D
    rating1.save()
    rating2.save()

    visit user_path(user.id)

    expect(page).to have_content "Username: MööttiTesti"
    expect(page).to have_content "Has made 2 ratings"

    expect(page).to have_content "Iso 3 20"
    expect(page).to have_content "Iso 3 30"
  end
end

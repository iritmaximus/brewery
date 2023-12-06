require "rails_helper"

describe "Places" do
  it "displays a place if one is returned from the api" do
    allow(Place).to receive(:weather).with("kumpula").and_return nil
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in("city", with: "kumpula")
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "displays all places if multiple are returned from the api" do
    allow(Place).to receive(:weather).with("kumpula").and_return nil
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ), Place.new( name: "Emt mitä paikkoja kumpulassa on", id: 2), Place.new( name: ":D", id: 3) ]
    )

    visit places_path
    fill_in("city", with: "kumpula")
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Emt mitä paikkoja kumpulassa on"
    expect(page).to have_content ":D"
  end

  it "displays 'No locations in _city_' if none is returned by the api" do
    allow(Place).to receive(:weather).with("kumpula").and_return nil
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      []
    )

    visit places_path
    fill_in("city", with: "kumpula")
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end
end

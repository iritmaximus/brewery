require "rails_helper"

describe "Beermapping API" do
  it "when HTTP GET returns one entry, it is parsed and returned" do

    http_response_body = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>18856</id><name>Panimoravintola Koulu</name><status>Brewpub</status><reviewlink>https://beermapping.com/location/18856</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18856&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18856&amp;d=1&amp;type=norm</blogmap><street>Eerikinkatu 18</street><city>Turku</city><state></state><zip>20100</zip><country>Finland</country><phone>(02) 274 5757</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING
    stub_request(:get, /.*turku/).to_return(body: http_response_body, headers: { "Content-Type" => "text/xml" })

    places = BeermappingApi.places_in("turku")

    expect(places.size).to eq 1

    place = places.first
    expect(place.name).to eq "Panimoravintola Koulu"
    expect(place.street).to eq "Eerikinkatu 18"
  end

  it "should return empty array when no places are returned from api" do
    http_response_body = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>6742</id><name>Pullman Bar</name><status>Beer Bar</status><reviewlink>https://beermapping.com/location/6742</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=6742&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=6742&amp;d=1&amp;type=norm</blogmap><street>Kaivokatu 1</street><city>Helsinki</city><state></state><zip>00100</zip><country>Finland</country><phone>+358 9 0307 22</phone><overall>72.500025</overall><imagecount>0</imagecount></location><location><id>6743</id><name>Belge</name><status>Beer Bar</status><reviewlink>https://beermapping.com/location/6743</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=6743&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=6743&amp;d=1&amp;type=norm</blogmap><street>Kluuvikatu 5</street><city>Helsinki</city><state></state><zip>00100</zip><country>Finland</country><phone>+358 10 766 35</phone><overall>67.499925</overall><imagecount>1</imagecount></location></bmp_locations>
    END_OF_STRING
    stub_request(:get, /.*helsinki/).to_return(body: http_response_body, headers: { "Content-Type": "text/xml" })

    places = BeermappingApi.places_in("helsinki")
    first_place = places[0]
    second_place = places[1]

    expect(first_place.name).to eq "Pullman Bar"
    expect(first_place.street).to eq "Kaivokatu 1"

    expect(second_place.name).to eq "Belge"
    expect(second_place.street).to eq "Kluuvikatu 5"

    expect(first_place.class).to eq Place
    expect(second_place.class).to eq Place
  end
end

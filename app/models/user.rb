class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :password, length: { minimum: 3 }
  validate :proper_characters_in_password?

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def proper_characters_in_password?
    regex = "(?=.*[[:upper:]])(?=.*[0-9])"
    return false if password&.match(regex)

    errors.add :password, "doesn't contain uppercase letter and a number"
  end

  def favorite_style
    styles = favorite_attribute "styles"
    item_with_most_points(styles)
  end

  def favorite_brewery
    breweries = favorite_attribute "breweries"
    item_with_most_points(breweries)
  end

  private

  def favorite_attribute(target)
    # not the fastest implementation but its DRY complient

    items = {}
    ratings.each do |rating|
      style = Style.find_by_id rating.beer.style_id
      attributes = {
        # create hash with key being style name and value first 0 and then the score
        "styles" => style.name,
        # iterate through ratings and add scores depending on
        # which brewery the beer that was rated was made in
        "breweries" => rating.beer.brewery.name
      }

      raise "Incorrect target" if attributes[target].nil?

      if items[attributes[target]].nil?
        items[attributes[target]] = rating.score
      else
        items[attributes[target]] += rating.score
      end
    end
    items
  end

  def item_with_most_points(items)
    highest = { name: "", total: 0 }
    items.each do |item|
      if item[1] > highest[:total]
        highest[:name] = item[0]
        highest[:total] = item[1]
      end
    end
    highest[:name]
  end
end

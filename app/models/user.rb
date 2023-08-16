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
    # create hash with key being style name and value first 0 and then the score
    styles = {}
    ratings.each do |rating|
      if styles[rating.beer.style].nil?
        styles[rating.beer.style] = rating.score
      else
        styles[rating.beer.style] += rating.score
      end
    end
    # determine which style hast the most points
    style_with_most_points(styles)
  end

  private

  def style_with_most_points(styles)
    highest = { name: "", total: 0 }
    styles.each do |style|
      if style[1] > highest[:total]
        highest[:name] = style[0]
        highest[:total] = style[1]
      end
    end
    highest[:name]
  end
end

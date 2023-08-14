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
end

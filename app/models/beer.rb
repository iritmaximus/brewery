class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :users, through: :ratings

  validates :name, presence: true
  validates :style_id, presence: true

  def to_s
    "#{name}, #{(Brewery.find_by_id brewery_id).name}"
  end
end

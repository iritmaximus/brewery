class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  validates :name, presence: true

  def to_s
    "#{name}, #{(Brewery.find_by_id brewery_id).name}"
  end
end

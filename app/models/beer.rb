class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    average = 0
    self.ratings.each do |rating|
      average += rating.score
    end
    return average
  end

  def to_s
    "#{self.name}, #{(Brewery.find_by_id self.brewery_id).name}"
  end
end

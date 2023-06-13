class Beer < ApplicationRecord
  belongs_to :brewery
  has_many :ratings

  def average_rating
    average = 0
    self.ratings.each do |rating|
      average += rating.score
    end
    return average
  end
end

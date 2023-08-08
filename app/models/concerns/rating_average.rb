module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    total_score = 0
    count = 0

    beers = if defined? self.beers
              self.beers
            else
              self
            end

    beers.each do |beer|
      count += beer.ratings.count
      beer.ratings.each do |rating|
        total_score += rating.score
      end
    end

    return 0 unless count != 0

    total_score / count
  end

  def count_ratings
    beers = if defined? self.beers
              self.beers
            else
              self
            end

    count = 0
    beers.each do |beer|
      count += beer.ratings.count
    end
    count
  end
end

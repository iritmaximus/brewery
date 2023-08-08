module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    total_score = 0
    count = 0

    if defined? self.beers
      beers = self.beers
    else
      beers = self
    end

    beers.each do |beer|
      count += beer.ratings.count
      beer.ratings.each do |rating|
        total_score += rating.score
      end
    end

    if count == 0
      return 0
    end

     return total_score / count
  end

  def count_ratings
    if defined? self.beers
      beers = self.beers
    else
      beers = self
    end

    count = 0
    beers.each do |beer|
      count += beer.ratings.count
    end
    return count
  end
end

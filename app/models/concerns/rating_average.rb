module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    if instance_of?(Beer)
      ratings = self.ratings
    elsif instance_of?(Brewery)
      # creates empty arrays for beers that have no ratings
      # + wraps the array in an array
      ratings = beers.map(&:ratings).reject(&:blank?)[0]
    elsif instance_of?(User)
      ratings = self.ratings
    else
      raise "Wrong class type for calculating average, #{self.class}"
    end

    return 0 unless ratings && ratings.count > 0

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def count_ratings
    if instance_of?(Beer) || User
      ratings.count
    elsif instance_of?(Brewery)
      beers.map(&:ratings.count).sum
    else
      raise "Wrong class type for counting ratings, #{self.class}"
    end
  end
end

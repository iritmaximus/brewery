module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    if self.class == Beer
      ratings = [self]
    elsif self.class == Brewery
      # creates empty arrays for beers that have no ratings
      # + wraps the array in an array
      ratings = beers.map { |b| b.ratings }.reject(&:blank?)[0]
    elsif self.class == User
      ratings = self.ratings
    else
      raise "Wrong class type for calculating average, #{self.class}"
    end

    return 0 unless ratings.count > 0
    ratings.map { |r| r.score }.sum / ratings.count.to_f
  end

  def count_ratings
    if self.class == Beer or User
      return self.ratings.count
    elsif self.class == Brewery
      return self.beers.map { |b| b.ratings.count }.sum
    else
      raise "Wrong class type for counting ratings, #{self.class}"
    end
  end
end

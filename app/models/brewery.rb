class Brewery < ApplicationRecord
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2023
    puts "changed year to #{2023}"
  end

  def average_rating
    total_score = 0
    count = self.count_ratings
    if count == 0
      return 0
    end

    self.beers.each do |beer|
      beer.ratings.each do |rating|
        total_score += rating.score
      end
    end

     return total_score / count
    "This brewery has #{count} #{pluralize count, "rating"} with an average of #{average}"
  end

  def count_ratings
    count = 0
    self.beers.each do |beer|
      count += beer.ratings.count
    end

    return count
  end
end

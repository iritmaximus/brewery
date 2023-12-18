class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1040,
                                   only_integer: true }
  validate :creation_year_not_in_future

  def creation_year_not_in_future
    return unless year > Time.now.year

    errors.add :year, "cannot be in the future"
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2023
    puts "changed year to 2023"
  end

  def self.top n
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| b.average_rating }.reverse.take(n)
  end
end

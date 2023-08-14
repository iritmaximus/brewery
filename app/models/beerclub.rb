class Beerclub < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :membership

  validates :name, presence: true
  validates :founded, numericality: { greater_than_or_equal_to: 1040,
                                      only_integer: true }
  validate :creation_year_not_in_future

  def creation_year_not_in_future
    return unless founded > Time.now.year

    errors.add :founded, "cannot be in the future"
  end
end

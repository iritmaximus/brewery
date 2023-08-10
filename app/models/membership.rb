class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :beerclub

  validate :user_not_in_club

  def user_not_in_club
    if not Membership.find_by(user_id:user_id, beerclub_id:beerclub_id).nil?
      errors.add :user_id, "is already in the beerclub"
    end
  end
end

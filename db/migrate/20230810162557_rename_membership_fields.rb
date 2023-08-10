class RenameMembershipFields < ActiveRecord::Migration[7.0]
  def change
    rename_column :memberships, :beer_club_id, :beerclub_id
  end
end

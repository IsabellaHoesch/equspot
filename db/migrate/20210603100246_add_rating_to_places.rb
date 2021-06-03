class AddRatingToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :rating, :integer
  end
end

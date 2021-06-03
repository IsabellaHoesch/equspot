class RemoveRatingFromPlaces < ActiveRecord::Migration[6.0]
  def change
    remove_column :places, :rating, :integer
  end
end

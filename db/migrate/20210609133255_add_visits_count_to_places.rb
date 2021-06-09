class AddVisitsCountToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :visits_count, :integer
  end
end

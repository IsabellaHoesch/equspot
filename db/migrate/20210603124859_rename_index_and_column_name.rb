class RenameIndexAndColumnName < ActiveRecord::Migration[6.0]
  def change
    # rename_column :reviews, :places_id, :place_id
    rename_index :reviews, 'places_id', 'place_id'
  end
end

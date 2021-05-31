class CreateSportCombinations < ActiveRecord::Migration[6.0]
  def change
    create_table :sport_combinations do |t|
      t.references :sport_type, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class RenameSecondName < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :second_name, :last_name
  end
end

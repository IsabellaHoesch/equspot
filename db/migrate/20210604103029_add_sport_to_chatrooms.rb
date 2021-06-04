class AddSportToChatrooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :chatrooms, :sport_type, null: false, foreign_key: true
  end
end

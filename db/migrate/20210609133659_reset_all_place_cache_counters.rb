class ResetAllPlaceCacheCounters < ActiveRecord::Migration[6.0]
  def change
    def up
      Place.all.each do |place|
        Place.reset_counters(place.id, :visits)
      end
    end
    def down
     # no rollback needed
    end
  end
end

class SportCombination < ApplicationRecord
  belongs_to :sport_type
  belongs_to :place
end

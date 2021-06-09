class Visit < ApplicationRecord
  belongs_to :user
  belongs_to :place, counter_cache: true
end

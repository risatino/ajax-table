class City < ApplicationRecord
  belongs_to :country
  validates :name, :population, presence: true
end



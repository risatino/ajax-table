class Country < ApplicationRecord
  has_many :cities, dependent: :destroy
  validates :name, :population, presence: true
end

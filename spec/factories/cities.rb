require 'faker'

FactoryGirl.define do
  factory :city do
    association :country
    name { Faker::Address.country }
    population { Faker::Number.number(7) }
  end
end

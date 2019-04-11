require 'factory_bot'

FactoryBot.define do
  factory :party do
    name {"The Party"}
    description {"A party"}
    location {"Home"}
  end
end

require 'faker'

FactoryBot.define do
  factory :client do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    status { 'New' }
  end
end
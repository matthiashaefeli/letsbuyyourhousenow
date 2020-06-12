require 'faker'

FactoryBot.define do
  factory :page_view do
    title { 'home_index' }
    count { 1 }
  end
end
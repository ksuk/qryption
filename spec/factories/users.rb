FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}@test.com" }
    password 'password'
  end
end

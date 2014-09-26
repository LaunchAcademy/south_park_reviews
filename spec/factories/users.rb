FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "frank#{n}@tank.com" }
    sequence(:username) { |n| "frank#{n}" }
    password 'abcd1234'
    password_confirmation 'abcd1234'

    trait :admin do
      role 'admin'
    end

    factory :admin, traits: [:admin]
  end
end

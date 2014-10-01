FactoryGirl.define do
  factory :vote do
    association :user
    association :voteable, factory: :episode

    value 1
  end
end

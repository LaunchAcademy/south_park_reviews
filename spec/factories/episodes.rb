FactoryGirl.define do
  factory :episode do
    title "An Elephant Makes Love to a Pig"
    release_date "1995-10-10"
    season 20
    sequence(:episode_number) { |n| n }
  end
end

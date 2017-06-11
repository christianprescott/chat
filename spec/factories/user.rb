FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
  end
end

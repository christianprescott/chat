FactoryGirl.define do
  factory :message do
    body "this is a very exciting post"
    association :conversation
    association :user
  end
end

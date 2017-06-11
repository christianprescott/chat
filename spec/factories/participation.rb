FactoryGirl.define do
  factory :participation do
    association :user
    association :conversation
  end
end

FactorGirl.define do
  factory :contact do
    firstname "John"
    lastname "Doe"
    sequence(:email) { |n| "johndone#{n}@example.com"}
  end
end

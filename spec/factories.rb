FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@gmail.com"
  end

  sequence :name do |n|
    "name#{n}"
  end

  factory :like do
    association :user
  end

  factory :post do
    association :quote
    association :user
  end

  factory :quote do
    text "Quote Text"
  end

  factory :relationship do
    association :follower
    association :followed
  end

  factory :source do
    name
  end

  factory :user do
    first_name "Paul"
    last_name "Jovanovic"
    email
    password "password"
    password_confirmation "password"
  end
end

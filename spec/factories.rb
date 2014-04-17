FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@gmail.com"
  end

  factory :user do
    first_name "Paul"
    last_name "Jovanovic"
    email
    password "password"
    password_confirmation "password"
  end

  factory :relationship do
    association :follower
    association :followed
  end
end
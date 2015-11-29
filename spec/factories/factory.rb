FactoryGirl.define do
  factory :user do

  end
  factory :auth_token do
    user
    token "hoehoge"
  end
  factory :user_info do
    user
    name "random"
    email "random@gmail.com"
    screen_name "random"
    password "random"
  end
end
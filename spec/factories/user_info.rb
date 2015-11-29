FactoryGirl.define do
  factory :user_info do
    user
    email { generate :email }
    screen_name { generate :screen_name }
    password { generate :password }
  end
end

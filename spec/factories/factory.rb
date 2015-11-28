FactoryGirl.define do
  factory :user do

  end
  factory :auth_token do
    user
    token "hoehoge"
  end
end
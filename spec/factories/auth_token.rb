FactoryGirl.define do
  factory :auth_token do
    user
    token {generate :auth_token}
  end
end
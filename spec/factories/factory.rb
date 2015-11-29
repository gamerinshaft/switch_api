require 'faker'
FactoryGirl.define do
  sequence(:screen_name){ Faker::Name.first_name }
  sequence(:email){ Faker::Internet.email }
  sequence(:password){ Faker::Internet.password }
  sequence(:auth_token){ SecureRandom.urlsafe_base64 }
end
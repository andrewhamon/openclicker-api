FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    token { SecureRandom.uuid }
  end
end

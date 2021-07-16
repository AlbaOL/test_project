FactoryBot.define do
  sequence :email do |n|
    "'user_#{n}@email.com'"
  end
  factory :user do
    email
    password { 'Test123!' }
  end
end

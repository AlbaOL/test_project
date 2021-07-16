FactoryBot.define do
  sequence :rider_id do |n|
    "'rider#{n}'"
  end
  factory :license do
    rider_name { "Laura" }
    rider_id
    rider_license_id { "12345" }
    sex { "H" }
    expiration_date { Time.now }
    rider_birth_date { 21.years.ago }
  end
end

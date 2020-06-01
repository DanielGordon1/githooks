FactoryBot.define do
  factory :user do
    name { "Dave Bananas#{rand(1..10)}" }
    email { "example@email.com#{rand(1..10)}" }
    external_id { 12345678 + rand(1..10) }
  end
end

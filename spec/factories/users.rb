FactoryBot.define do
  factory :user do
    name { "Dave Bananas" }
    email { "example@email.com" }
    external_id { 12345678 }
  end
end

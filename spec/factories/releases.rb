FactoryBot.define do
  factory :release do
    tag_name { "1.2.1" }
    released_at { "2020-05-25 13:38:13" }
    external_id { 12345 }
    user { association(:user) }
  end
end

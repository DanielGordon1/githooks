FactoryBot.define do
  factory :release do
    author { association(:user) }
    tag_name { "1.2.1 stable" }
    released_at { "2020-05-25 13:38:13" }
    external_id { 12345 }
  end
end

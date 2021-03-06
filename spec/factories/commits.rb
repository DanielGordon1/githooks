FactoryBot.define do
  factory :commit do
    message { "FEAT: This is now done" }
    sha { "3cb53bc31415221cfb92358dd6f7f05d6f139fec" }
    committed_at { "2020-05-25 14:25:09" }
    ticket_identifiers do
      {
        eve: ['214', '211'],
        sp: ['421']
      }
    end
    author { association(:user) }
    release { association(:release) }
    repository_name { "suitepad_apk" }
  end
end

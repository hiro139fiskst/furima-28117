FactoryBot.define do
  factory :user do
    nickname { 'ハム太郎' }
    email { Faker::Internet.free_email }
    password { 'test123456' }
    password_confirmation { password }
    first_name { 'やまだ' }
    last_name { 'りくたろう' }
    first_name_kana { 'ヤマダ' }
    last_name_kana { 'リクタロウ' }
    birth_date { '2010-01-01' }
  end
end

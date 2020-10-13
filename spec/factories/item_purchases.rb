FactoryBot.define do
  factory :item_purchase do
    user_id { 5 }
    item_id { 5 }
    token { 'aaaaaaaaaaaaaaaaaaaaaa' }
    post_code { '113-0011' }
    prefecture_id { 3 }
    city { '東京都' }
    address_number { '文京区' }
    building_name { 'グランド文京' }
    phone_number { '09012345678' }
  end
end

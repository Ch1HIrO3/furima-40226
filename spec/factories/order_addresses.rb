FactoryBot.define do
  factory :order_address do

    zip_code{ '123-1234' }
    state_province_id{ Faker::Number.between(from: 2, to: 48) }
    city_town_village{ Gimei.address.city.kanji }
    street_address{ Gimei.address.town.kanji }
    building_name{ Gimei.address.town.kanji }
    telephone{ Faker::Number.number(digits: 10) }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
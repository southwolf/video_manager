FactoryGirl.define do
  factory :video, class: Videos::Video do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
  end
end

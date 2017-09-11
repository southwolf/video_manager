FactoryGirl.define do
  factory :comment, class: Comments::Comment do
    video_id { SecureRandom.uuid }
    commenter_id { SecureRandom.uuid }
    text { Faker::Lovecraft.paragraph }
  end
end
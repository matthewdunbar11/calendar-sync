FactoryBot.define do
  factory :event do
    title { "Youth Fundraiser" }
    start { DateTime.current }
    add_attribute(:end) { DateTime.current + 30.minutes }
    description { "This will be a <strong>fun</strong> time" }
    calendar
  end
end

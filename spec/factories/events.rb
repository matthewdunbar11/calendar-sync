FactoryBot.define do
  factory :event do
    name { "MyString" }
    start_datetime { DateTime.current }
    end_datetime { DateTime.current + 30.minutes }
    calendar
  end
end

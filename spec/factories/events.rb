FactoryBot.define do
  factory :event do
    name { "MyString" }
    datetime { DateTime.current }
    calendar
  end
end

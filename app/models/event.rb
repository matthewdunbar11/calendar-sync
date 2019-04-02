class Event < ApplicationRecord
  belongs_to :calendar

  validates :name, :datetime, presence: true
end

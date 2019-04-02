class Event < ApplicationRecord
  belongs_to :calendar

  validates :name, :start_datetime, :end_datetime, presence: true
end

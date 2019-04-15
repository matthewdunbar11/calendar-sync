class Event < ApplicationRecord
  belongs_to :calendar

  validates :title, :start, :end, presence: true
end

class Event < ApplicationRecord
  belongs_to :calendar

  validates :title, :start, :end, presence: true

  has_rich_text :description
end

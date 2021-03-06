class Event < ApplicationRecord
  belongs_to :calendar

  validates :title, :start, :end, presence: true

  has_rich_text :description
  
  rails_admin do
    configure :id do
      visible false
    end

    configure :created_at do
      visible false
    end

    configure :updated_at do
      visible false
    end

    configure :start do
      strftime_format '%B %d, %Y %I:%M %p'
      datepicker_options do 
        { showTodayButton: false, format: parser.to_momentjs }
      end
    end

    configure :end do
      strftime_format '%B %d, %Y %I:%M %p'
      datepicker_options do 
        { showTodayButton: false, format: parser.to_momentjs }
      end
    end

    list do
      configure :description do
        visible false
      end
    end
  end
end

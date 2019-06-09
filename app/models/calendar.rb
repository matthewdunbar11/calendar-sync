class Calendar < ApplicationRecord
  belongs_to :user
  has_many :events


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

    configure :events do
      visible false
    end

    configure :user do
      visible false
    end

    edit do
      field :name
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end 
  end
end

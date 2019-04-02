require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'model validations' do
    it 'requires a datetime' do
      event = FactoryBot.build(:event, datetime: nil)
      expect(event).not_to be_valid
      event.datetime = DateTime.new
      expect(event).to be_valid
    end

    it 'requires a name' do
      event = FactoryBot.build(:event, name: nil)
      expect(event).not_to be_valid
      event.name = 'Test'
      expect(event).to be_valid
    end
  end
end

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'model validations' do
    it 'requires a start_datetime' do
      event = FactoryBot.build(:event, start_datetime: nil)
      expect(event).not_to be_valid
      event.start_datetime = DateTime.new
      expect(event).to be_valid
    end

    it 'requires an end_datetime' do
      event = FactoryBot.build(:event, end_datetime: nil)
      expect(event).not_to be_valid
      event.end_datetime = DateTime.new
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

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'model validations' do
    it 'requires a start' do
      event = FactoryBot.build(:event, start: nil)
      expect(event).not_to be_valid
      event.start = DateTime.new
      expect(event).to be_valid
    end

    it 'requires an end' do
      event = FactoryBot.build(:event, end: nil)
      expect(event).not_to be_valid
      event.end = DateTime.new
      expect(event).to be_valid
    end

    it 'requires a title' do
      event = FactoryBot.build(:event, title: nil)
      expect(event).not_to be_valid
      event.title = 'Test'
      expect(event).to be_valid
    end
  end
end

require 'rails_helper'

RSpec.feature 'events' do
  let(:calendar) { FactoryBot.create(:calendar) }
  
  before do
    sign_in calendar.user
  end

  scenario 'list events' do
    other_calendar = FactoryBot.create(:calendar)

    event1 = FactoryBot.create(:event, calendar: calendar)
    event2 = FactoryBot.create(:event, calendar: calendar)
    other_event = FactoryBot.create(:event, calendar: other_calendar)

    visit calendar_path(calendar)

    expect(page).to have_selector("[data-id='#{event1.id}']")
    expect(page).to have_selector("[data-id='#{event2.id}']")
    expect(page).not_to have_selector("[data-id='#{other_event.id}']")
  end

  scenario 'webcal list of events' do
    other_calendar = FactoryBot.create(:calendar)

    event1 = FactoryBot.create(:event, title: 'Event 1', calendar: calendar)
    event2 = FactoryBot.create(:event, title: 'Event 2', calendar: calendar)
    other_event = FactoryBot.create(:event, title: 'Other Event', calendar: other_calendar)
    
    visit calendar_path(calendar)
    click_on 'Add to iPhone Calendar'
    
    expect(page).to have_content('BEGIN:VCALENDAR')
    expect(page).to have_content(event1.title)
    expect(page).to have_content(event2.title)
    expect(page).not_to have_content(other_event.title)
  end

  scenario 'anonymously view an event' do
    event = FactoryBot.create(:event)
    visit event_path(event)
    expect(page).to have_content(event.title)
  end
end
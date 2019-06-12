require 'rails_helper'

RSpec.feature 'calendars' do
  scenario 'view javascript calendar', js: true do
    event = FactoryBot.create(:event)

    visit calendar_path(event.calendar)
    expect(page).to have_selector('.fc')
    expect(page).to have_content(event.title)
    click_on event.title
    expect(page).to have_content(event.title)
    expect(current_path).to eq(event_path(event))
  end

  scenario 'view javascript calendar in presentation mode', js: true do
    event = FactoryBot.create(:event)

    visit present_calendar_path(event.calendar)
    expect(page).to have_selector('.fc')
    expect(page).not_to have_content('Home')
  end
end
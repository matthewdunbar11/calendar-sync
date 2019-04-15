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

  scenario 'creating an event' do
    visit calendar_path(calendar)
    click_on 'Add New Event'

    event_attributes = FactoryBot.attributes_for(:event)
    fill_in 'Title', with: event_attributes[:title]

    fill_in 'Start Date', with: event_attributes[:start]
    fill_in 'End Date', with: event_attributes[:end]

    click_on 'Create Event'
    expect(page).to have_content('Event successfully created')
    expect(page).to have_content(event_attributes[:title])
  end

  scenario 'editing an event' do
    event = FactoryBot.create(:event, calendar: calendar)
    visit calendar_path(calendar)
    find("[data-id='#{event.id}']").click_on 'Edit'
    fill_in 'Title', with: 'A New title'
    click_on 'Update Event'

    expect(page).to have_content('Event successfully updated')
    expect(page).to have_content('A New title')
  end

  scenario 'deleting an event' do
    event = FactoryBot.create(:event, calendar: calendar)
    visit calendar_path(calendar)

    find("[data-id='#{event.id}']").click_on 'Delete'
    
    expect(page).to have_content('Event successfully deleted')
    expect(page).not_to have_selector("[data-id='#{event.id}']")
  end
end

def select_date_and_time(date, options = {})
  field = options[:from]
  select date.strftime('%Y'),    from: "#{field}_1i" #year
  select date.strftime('%B'),    from: "#{field}_2i" #month
  select date.strftime('%-d'),   from: "#{field}_3i" #day 
  select date.strftime('%I %p'), from: "#{field}_4i" #hour
  select date.strftime('%M'),    from: "#{field}_5i" #minute
end
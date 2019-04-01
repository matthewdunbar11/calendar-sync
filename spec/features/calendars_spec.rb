require 'rails_helper'

RSpec.feature 'calendars' do
  scenario 'listing calendars' do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    calendar1a = FactoryBot.create(:calendar, user: user1)
    calendar1b = FactoryBot.create(:calendar, user: user1)
    calendar2 = FactoryBot.create(:calendar, user: user2)

    sign_in user1
    
    visit calendars_path

    expect(page).to have_selector("[data-id='#{calendar1a.id}']")
    expect(page).to have_selector("[data-id='#{calendar1b.id}']")
    expect(page).not_to have_selector("[data-id='#{calendar2.id}']")
  end

  scenario 'creating a new calendar' do
    user = User.create!(email: 'test@test.com', password: 'ABC123', password_confirmation: 'ABC123')
    sign_in user
    visit root_path
    click_on "Hello, #{user.email}"
    click_on 'New'

    fill_in 'Name', with: 'Default Calendar'
    click_on 'Create Calendar'
    expect(page).to have_content('Calendar successfully created')
    expect(page).to have_content('Default Calendar')
  end

  scenario 'editing a calendar' do
    calendar = FactoryBot.create(:calendar)

    sign_in calendar.user
    
    visit calendars_path
    find("[data-id='#{calendar.id}']").click_on 'View'
    click_on 'Edit'
    fill_in 'Name', with: 'A New Calendar Name'
    click_on 'Update Calendar'
    expect(page).to have_content('Calendar successfully updated')
    expect(page).to have_content('A New Calendar Name')
  end

  scenario 'deleting a calendar' do
    calendar = FactoryBot.create(:calendar)

    sign_in calendar.user

    visit calendars_path
    find("[data-id='#{calendar.id}']").click_on 'View'
    click_on 'Delete'
    expect(current_path).to eq(calendars_path)
    expect(page).to have_content('Calendar successfully deleted')
    expect(page).not_to have_selector("[data-id='#{calendar.id}']")
  end
end
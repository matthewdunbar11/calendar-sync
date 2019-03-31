require 'rails_helper'

RSpec.feature 'calendars' do
  scenario 'creating a new calendar' do
    user = User.create!(email: 'test@test.com', password: 'ABC123', password_confirmation: 'ABC123')
    sign_in user
    visit root_path
    click_on "Hello, #{user.email}"
    click_on 'New'

    fill_in 'Name', with: 'Default Calendar'
    click_on 'Create Calendar'
    expect(page).to have_content('Default Calendar')
  end

  scenario 'editing a calendar'
end
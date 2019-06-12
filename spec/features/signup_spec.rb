require 'rails_helper'

RSpec.feature 'signup' do
  scenario 'a new user account' do
    visit root_path
    click_on 'Get Started'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'ABC123'
    fill_in 'Password confirmation', with: 'ABC123'
    click_on 'Sign up'
    expect(page).to have_content('Site Administration')
  end
end
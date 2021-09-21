require 'spec_helper'

feature 'signup' do
  scenario 'user can signup' do
    visit('/')
    fill_in 'name', with: 'John'
    fill_in 'email', with: 'test@email.com'
    fill_in 'password', with: 'test_password'
    click_button 'Submit'
    expect(page).to have_content 'Welcome'
  end
end
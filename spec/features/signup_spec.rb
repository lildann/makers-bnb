require 'spec_helper'

feature 'registration' do
  scenario 'user can sign up' do
    visit('/')
    fill_in 'name', with: 'John'
    fill_in 'email', with: 'test@email.com'
    fill_in 'password', with: 'test_password'
    click_button 'Sign up'
    expect(page).to have_content 'Welcome'
  end
end
require 'spec_helper'

feature 'authentication' do
  scenario 'user can login' do
    User.create(name: 'John', email: 'test@email.com', password: 'test-password')
    visit('/login')
    fill_in 'email', with: 'test@email.com'
    fill_in 'password', with: 'test-password'
    click_button 'Login'
    expect(page).to have_content 'Welcome, John'
    expect(page.current_path).to eq '/spaces'
  end
end
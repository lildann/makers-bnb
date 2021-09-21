require 'spec_helper'

feature 'login' do
  scenario 'user can login' do
    visit('/login')
    fill_in 'name', with: 'John'
    fill_in 'email', with: 'test@email.com'
    fill_in 'password', with: 'test_password'
    click_button 'Submit'
    expect(page).to have_content 'Welcome'
    expect(page.current_path).to eq '/spaces'
  end
end
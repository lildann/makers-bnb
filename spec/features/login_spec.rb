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

  scenario "email incorrect user cannot login" do
    User.create(name: 'John', email: 'test@email.com', password: 'test-password')
    visit('/login')
    fill_in 'email', with: 'incorrect@email.com'
    fill_in 'password', with: 'test-password'
    click_button 'Login'
    expect(page).to have_content 'Incorrect email or password'
    expect(page.current_path).to eq '/login'
  end

  scenario "password incorrect user cannot login" do
    User.create(name: 'John', email: 'test@email.com', password: 'test-password')
    visit('/login')
    fill_in 'email', with: 'test@email.com'
    fill_in 'password', with: 'incorrect'
    click_button 'Login'
    expect(page).to have_content 'Incorrect email or password'
    expect(page.current_path).to eq '/login'
  end

end
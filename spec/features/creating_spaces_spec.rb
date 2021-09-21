feature 'Creating spaces' do
    scenario 'a user can add a space' do
      visit '/spaces/new'
      fill_in('name', with: 'a new space')
      fill_in('description', with: 'description')
      fill_in('price_per_night', with: 100)
      
      click_button 'New space'

      expect(page).to have_content 'a new space'
    end


    scenario 'a user can see all the spaces' do
      visit '/spaces'
      expect(page).to have_content 'a new space'
    end
end
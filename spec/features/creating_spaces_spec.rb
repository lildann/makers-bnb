feature 'Creating spaces' do
    scenario 'a user can add a space' do
      visit '/spaces/new'
      fill_in('space_name', with: 'a new space')
      fill_in('space_description', with: 'description')
      fill_in('space_price', with: 'price')
      
      click_button 'New space'

      expect(page).to have_content 'a new space'
    end


    scenario 'a user can see all the spaces' do
      visit '/spaces'
      expect(page).to have_content 'this is all the spaces'
    end
end
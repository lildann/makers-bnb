# feature 'Creating spaces' do
#     scenario 'a user can add a space' do
#       visit '/spaces/new'
#       fill_in('name', with: 'a new space')
#       fill_in('description', with: 'this is the description')
#       fill_in('price_per_night', with: 100)
      
#       click_button 'Spaces'

#       expect(page).to have_content 'this is the description'
#     end


#     scenario 'a user can see all the spaces' do
#       visit '/spaces'
#       expect(page).to have_content 'this is the description'
#     end
# end
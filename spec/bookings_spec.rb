require 'bookings'

describe Bookings do

  let(:space_id) {1}
  let(:user_id) {1}
  let(:booking_date) {"10/09/2021"}  
  let(:description) {"this is the description"}
  let(:price_per_night) {100}
  let(:available_from) {"01/09/2021"} 
  let(:available_to) {"30/09/2021"}   

  before(:all) do
    connection = PG.connect(dbname: 'bnb_test', user: 'postgres', password: 'password')    
    connection.exec ("INSERT INTO spaces (space_name, space_description, price_per_night) VALUES ('A new Space', 'this is the description', '100');")
    connection.exec ("INSERT INTO available_dates (spaces_id, available_from, available_to) VALUES ('1', '01/09/2021', '30/09/2021');")
    connection.exec ("INSERT INTO available_dates (spaces_id, available_from, available_to) VALUES ('1', '01/12/2021', '30/12/2021');")
  end


  context 'checking all available dates' do
    it '.available_dates' do
      result = Bookings.available_dates
      expect(result[0]).to include "2021-09-01"
    end
  end
  
  it '.make_booking' do
    result = Bookings.make_booking(user_id, space_id, booking_date, TRUE)
    expect(result).to eq "This booking has been confirmed!"
  end

  it '.add_available_dates' do
    result = Bookings.add_available_dates(spaces_id: space_id, available_from: available_from, available_to: available_to)
    expect(result).to eq "Dates Added"
  end

  context 'check to see if the dates are available, if so, book the date' do 
    it '.check_booking' do
      result = Bookings.check_booking_dates(space_id, booking_date)
      expect(result).to eq false
    end
  end

  it 'stops the user booking a space if it is unavailable' do
  end

  it 'sends a confirmation message when booking confirmed' do
    result = Bookings.update_booking(space_id: space_id)
    expect(result).to eq "Booking now confirmed"
  end

end





  





# Junction Table: BOOKINGS
# user_ID | Space_ID | start_date | end_date
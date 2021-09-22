require 'bookings'

describe Bookings do

  let(:space_id) {1}
  let(:booking_from) {"10/09/2021"}
  let(:booking_to) {"15/09/2021"}
  let(:description) {"this is the description"}
  let(:price_per_night) {100}

  it '.available_dates' do
    connection = PG.connect(dbname: 'bnb_test', user: 'postgres', password: 'password')
    
    connection.exec ("INSERT INTO spaces (space_name, space_description, price_per_night) VALUES ('A new Space', 'this is the description', '100');")
    connection.exec ("INSERT INTO bookings (spaces_id, available_from, available_to) VALUES ('1', '01/09/2021', '30/09/2021');")
    connection.exec ("INSERT INTO bookings (spaces_id, available_from, available_to) VALUES ('1', '01/12/2021', '30/12/2021');")
    connection.exec ("SELECT space_name, price_per_night, available_from, available_to FROM bookings INNER JOIN spaces ON (spaces.spaces_id = bookings.spaces_id);") 

    result = Bookings.available_dates
    expect(result[0]).to include "2021-09-01"
  end

  it 'allows the user to book a space' do
    connection = PG.connect(dbname: 'bnb_test', user: 'postgres', password: 'password')

    # connection.exec ("INSERT INTO available_dates (spaces_id, available_from, available_to) VALUES ('1', '01/09/2021', '30/09/2021');")
    #connection.exec ("INSERT INTO bookings (spaces_id, available_from, available_to) VALUES ('#{space_id}','#{booking_from}','#{booking_to}');")
    result = Bookings.make_booking(space_id: space_id,available_from: booking_from, available_to: booking_to)
    expect(result[0]).to include("available_from" => "2021-09-10")
    
  end

  it 'stops the user booking a space if it is unavailable' do
  end

  it 'sends a confirmation message when booking confirmed' do
  end

end





  





# Junction Table: BOOKINGS
# user_ID | Space_ID | start_date | end_date
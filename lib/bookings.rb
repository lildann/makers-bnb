require 'pg'

class Bookings 

  def self.add_available_dates(spaces_id:, available_from:, available_to:)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec("INSERT INTO available_dates (spaces_id, available_from, available_to) VALUES ('#{spaces_id}', '#{available_from}', '#{available_to}');")
    "Dates Added"
  end

  def self.available_dates(spaces_id:)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec(
      "SELECT bookings_id, spaces.spaces_id, available_from, available_to FROM available_dates INNER JOIN
       spaces ON (spaces.spaces_id = available_dates.spaces_id) WHERE spaces.spaces_id = '#{spaces_id}';")
    result.values
  end

  def self.accepted_bookings(user_id:)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec(
      "SELECT bookings_id, spaces_id, booking_date, accepted, confirmed FROM bookings
       WHERE user_id = '#{user_id}';")
    result.values
  end

  def self.requests_made(user_id:)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec_params(
      "SELECT booking_date, accepted, confirmed FROM bookings
      WHERE user_id = '#{user_id}';")
    result.values
  end

  def self.make_booking(user_id, space_id, booking_date, accepted)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec_params("INSERT INTO bookings (user_id, spaces_id, booking_date, accepted)
     VALUES ('#{user_id}','#{space_id}','#{booking_date}','#{accepted}') RETURNING booking_date;")
    return "This booking has been accepted!"
  end

  def self.do_booking(user_id:, space_id:, booking_date:)    
    if self.check_available_dates(space_id, booking_date) == true
      "Unavailable"      
    elsif self.check_booking_dates(space_id, booking_date) == false
      "Unavailable"
    else
      self.make_booking(user_id, space_id, booking_date, TRUE)
    end
  end

  def self.check_booking_dates(space_id, booking_date)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec("SELECT * FROM bookings WHERE spaces_id = 1 AND booking_date = '#{booking_date}' AND confirmed is NOT NULL;")
    p result.values.empty?
    result.values.empty?
  end
  
  # if user says this date, give me the acceptance message
  def self.check_available_dates(space_id, booking_date)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec("SELECT available_from, available_to FROM available_dates WHERE spaces_id = 1 AND available_from <= '#{booking_date}' AND available_to >= '#{booking_date}';")
    
    p result.values.empty?
    result.values.empty?
  end

  def self.update_booking(bookings_id:)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec("UPDATE bookings SET confirmed = TRUE WHERE bookings_id = '#{bookings_id}';")
    #send confirmation message to user
    "Booking now confirmed"
  end 

  def self.delete_booking(bookings_id:)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec("DELETE FROM bookings WHERE bookings_id = '#{bookings_id}';")
    #send confirmation message to user
    "Booking now confirmed"
  end 
end
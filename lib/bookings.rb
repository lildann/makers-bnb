require 'pg'

class Bookings 

  def self.available_dates()
    # go to the database, send a a query to return any property that is available
    # if ENV['ENVIRONMENT'] == "test"
    #     connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    # else
    #     connection = PG.connect(dbname:'bnb', user:'postgres', password:'password')
    # end

    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec("SELECT space_name, price_per_night, available_from, available_to FROM available_dates INNER JOIN spaces ON (spaces.spaces_id = available_dates.spaces_id);")
    #connection.exec ("INSERT INTO bookings (spaces_id, available_from, available_to) VALUES ('1', '10/09/2021', '15/09/2021');")
    result.values
  end

  def self.make_booking(space_id:, available_from:, available_to:)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec ("INSERT INTO bookings (spaces_id, booking_from, booking_to) VALUES ('#{space_id}', '#{available_from}', '#{available_to}') RETURNING booking_from, booking_to;")
    #@from_date = result
    #@from_date = result[0]
    # from the database, any available spaces
  end

  def confirm_booking
    # if user says this date, give me the acceptance message
  end

  def unavailable?
    # if the space is unavailable, then send a message stopping the space from being picked
  end

  
end
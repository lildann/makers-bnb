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
    result = connection.exec(
      "SELECT spaces.spaces_id, available_from, available_to FROM available_dates INNER JOIN
       spaces ON (spaces.spaces_id = available_dates.spaces_id) WHERE spaces.spaces_id = 1;")
    result.values
  end

  def self.make_booking(space_id:, booking_date:)
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec ("INSERT INTO bookings (spaces_id, booking_date) VALUES ('#{space_id}', '#{booking_date}') RETURNING booking_date;")
    #@from_date = result
    #@from_date = result[0]
    # from the database, any available spaces
  end

  def confirm_booking(space_id:, booking_date:)
    # if user says this date, give me the acceptance message
    connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
    result = connection.exec("SELECT * FROM available_dates WHERE spaces_id = 1 AND available_from <= '#{booking_date}' AND available_to > '#{booking_date}';")
  end

  def unavailable?
    # if the space is unavailable, then send a message stopping the space from being picked
  end

  
end
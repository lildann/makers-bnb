require 'pg'

p "Setting up test database..."

def setup_test_database
    connection = PG.connect(dbname: 'bnb_test', user: 'postgres', password: 'password')
    connection.exec("TRUNCATE spaces, available_dates, bookings RESTART IDENTITY;")
end


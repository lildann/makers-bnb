require 'pg'

p "Setting up test database..."

def setup_test_database
    connection = PG.connect(dbname: 'bnb', user: 'postgres', password: 'password')
    connection.exec("TRUNCATE spaces RESTART IDENTITY;")
end


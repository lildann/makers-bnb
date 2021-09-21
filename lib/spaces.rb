require 'pg'
#require_relative 'database_connection'

class Spaces

    def self.create(name:, description:, price_per_night:)
        connection = PG.connect(dbname: 'bnbapp', user: 'postgres', password: 'password')
        connection.exec("INSERT INTO spaces (space_name, space_description, price_per_night) VALUES ('#{name}', '#{description}', '#{price_per_night}');")
    end

    def self.all
        connection = PG.connect(dbname: 'bnbapp', user: 'postgres', password: 'password')
        result = connection.exec("SELECT * FROM spaces;")

        result.values
    end

end
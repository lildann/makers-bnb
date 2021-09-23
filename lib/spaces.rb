require 'pg'
#require_relative 'database_connection'

class Spaces

    def self.create(name:, description:, price_per_night:)
        connection = PG.connect(dbname: 'bnb')
        new_space = connection.exec("INSERT INTO spaces (space_name, space_description, price_per_night) VALUES ('#{name}', '#{description}', '#{price_per_night}') RETURNING spaces_id;")
        new_space.values[0]
    end

    def self.all
        connection = PG.connect(dbname: 'bnb')
        result = connection.exec("SELECT * FROM spaces;")

        result.values
    end

end
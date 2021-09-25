require 'pg'
#require_relative 'database_connection'

class Spaces

    def self.create(name:, description:, price_per_night:)
        if ENV['ENVIRONMENT'] == "test"
            connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
        else
            connection = PG.connect(dbname:'bnb', user:'postgres', password:'password')
        end

        #connection = PG.connect(dbname: 'bnb', user: 'postgres', password: 'password')
        #new_space = connection.exec("INSERT INTO spaces (space_name, space_description, price_per_night) VALUES ('#{name}', '#{description}', '#{price_per_night}') RETURNING spaces_id;")
        new_space = connection.exec_params(
            "INSERT INTO spaces (space_name, space_description, price_per_night) VALUES ($1, $2, $3) 
            RETURNING spaces_id, space_name, space_description, price_per_night;", [spaces_id, name, description, price_per_night])
        
        new_space.values[0]
        
    end

    def self.all
        # if ENV['RACK_ENV'] == "test"
        #     connection = PG.connect(dbname:'bnb_test', user:'postgres', password:'password')
        # else
        #     connection = PG.connect(dbname:'bnb', user:'postgres', password:'password')
        # end

        connection = PG.connect(dbname: 'bnb_test', user: 'postgres', password: 'password')
        result = connection.exec("SELECT spaces_id, space_name, space_description, price_per_night FROM spaces;")

        result.values
    end

end
require 'spaces'

describe 'spaces' do

    it '.create' do
        connection = PG.connect(dbname: 'bnbapp', user: 'postgres', password: 'password')
        connection.exec("INSERT INTO spaces (space_name, space_description, price_per_night) VALUES ('A new Space', 'this is the description', '100');")

        Spaces.create((name,description,price_per_night)
        result = Spaces.all
        expect(result[0]).to include "this is the description"
    end

    it ".all" do
        result = Spaces.all
        expect(result[0]).to include "this is the description"
    end
end


require 'spaces'

describe 'spaces' do

    let(:name) {"this is the name"}
    let(:description) {"this is the description"}
    let(:price_per_night) {100}

    it '.create' do
        connection = PG.connect(dbname: 'bnb_test', user: 'postgres', password: 'password')
        connection.exec("INSERT INTO spaces (space_name, space_description, price_per_night) VALUES ('#{name}', '#{description}', '#{price_per_night}') RETURNING spaces_id, space_name, space_description, price_per_night;")

        Spaces.create(name: name, description: description, price_per_night: price_per_night)
        result = Spaces.all
        expect(result[0]).to include "this is the description"
    end

    it ".all" do
        result = Spaces.all
        expect(result[0]).to include "this is the description"
    end

end


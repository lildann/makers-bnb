require 'user'

describe User do

  context '#create' do
    it 'creates a new user' do
      user = User.create(name: 'John', email: 'test@email.com', password: 'test-password')

      expect(user).to be_a User
      expect(user.name).to eq 'John'
      expect(user.email).to eq 'test@email.com'
      expect(user.password).to eq 'test_password'
    end
  end
end


# require 'pg'

# def persisted_data(id:, table:)
#   connection = PG.connect(dbname: 'bookmark_manager_test')
#   connection.query("SELECT * FROM #{table} WHERE id = '#{id}';")
# end
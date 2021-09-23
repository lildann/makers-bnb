require 'user'
require 'database_helpers'

describe User do
  context '#create' do
    it 'creates a new user' do
      user = User.create(name: 'John', email: 'test@email.com', password: 'test-password')
      persisted_data = persisted_data(table: :users, id: user.id)
      expect(user).to be_a User
      expect(user.id).to eq persisted_data.first['id']
      expect(user.name).to eq 'John'
      expect(user.email).to eq 'test@email.com'
    end
    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('test-password')
      user = User.create(name: 'John', email: 'test@email.com', password: 'test-password')
    end
  end

  context '#find' do
    it 'finds a user by ID' do
      user = User.create(name: 'John', email: 'test@email.com', password: 'test-password')
      result = User.find(id: user.id)
  
      expect(result.id).to eq user.id
      expect(result.name).to eq user.name
      expect(result.email).to eq user.email
    end

    it 'returns nil if there is no ID given' do
      expect(User.find(id: nil)).to eq nil
    end
  end

  context '#authenticate' do
    it 'returns the user credentials if the user exists in the databse' do
      user = User.create(name: 'John', email: 'test@email.com', password: 'test-password')
      authenticate_user = User.authenticate(email: 'test@email.com', password: 'test-password')
      
      expect(user.id).to eq authenticate_user.id
    end

    it 'user inputs incorrect email, cannot login' do
      user = User.create(name: 'John', email: 'test@email.com', password: 'test-password')
      authenticate_user = User.authenticate(email: 'incorrect@email.com', password: 'test-password')
      expect(authenticate_user).to be_nil
    end

    it 'user inputs incorrect password, cannot login' do
      user = User.create(name: 'John', email: 'test@email.com', password: 'test-password')
      authenticate_user = User.authenticate(email: 'test@email.com', password: 'incorrect')
      expect(authenticate_user).to be_nil
    end


  end

end
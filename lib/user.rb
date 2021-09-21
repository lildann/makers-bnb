require 'pg'
require 'bcrypt'
require_relative './database_connection'

class User
  attr_reader :id,:name, :email

  def initialize(id:, name:, email:)
    @id = id
    @name = name
    @email = email
  end

  def self.create(name:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING id, name, email;", [name, email, password])
    User.new(
      id: result[0]['id'], 
      name: result[0]['name'], 
      email: result[0]['email'])
  end

  def self.find(id:)
    return nil unless id
    result = DatabaseConnection.query(
      "SELECT * FROM users WHERE id = $1", [id]
    )
    User.new(
      id: result[0]['id'],
      name: result[0]['name'],
      email: result[0]['email'],
    )
  end
end
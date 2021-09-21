require 'pg'

class User
  attr_reader :name, :email, :password

  def initialize(name:, email:, password:)
    @name = name
    @email = email
    @password = password
  end

  def self.create(name:, email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bnb_test')
    else
      connection = PG.connect(dbname: 'bnb')
    end
    result = connection.exec_params("INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING id, name, email, password;" [name, email, password])
    User.new(id: result[0]['id'], name: result[0]['name'], email: result[0]['email'], password: result[0]['password'])
  end

end
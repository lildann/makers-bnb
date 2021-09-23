<<<<<<< HEAD
require 'pg'

class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname, user: 'postgres', password: 'password')
  end

  def self.connection
    @connection
  end

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end

=======
require 'pg'

class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.connection
    @connection
  end

  def self.query(sql, params = [])
    @connection.exec_params(sql, params)
  end
>>>>>>> 48a078c1172aa22fa3bd98f051f8e55d833046fb
end
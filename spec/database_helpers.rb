require 'pg'

# def persisted_data(id:)
#   connection = PG.connect(dbname: 'bnb_test')
#   connection.query(
#     "SELECT * FROM users WHERE id = $1;", [id]
#   )
# end

def persisted_data(id:, table:)
  connection = PG.connect(dbname: 'bnb_test')
  connection.query("SELECT * FROM #{table} WHERE id = '#{id}';")
end
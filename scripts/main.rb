require 'pg'

class DatabaseManager
  def initialize(dbname, user, password, host, port)
    @conn = PG.connect(dbname: dbname, user: user, password: password, host: host, port: port)
  end

  def create_table
    @conn.exec("CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, name VARCHAR)")
  end

  def insert_user(name)
    @conn.exec_params("INSERT INTO users (name) VALUES ($1)", [name])
  end

  def fetch_users
    result = @conn.exec("SELECT * FROM users")
    result.map { |row| { id: row['id'], name: row['name'] } }
  end

  def close_connection
    @conn.close if @conn
  end

  def test
    1
  end
end

# Пример использования класса DatabaseManager для работы с базой данных
db_manager = DatabaseManager.new('имя_базы_данных', 'пользователь', 'пароль', 'хост', 'порт')
db_manager.create_table
db_manager.insert_user('Имя пользователя')
users = db_manager.fetch_users
users.each { |user| puts "ID: #{user[:id]}, Имя: #{user[:name]}" }
db_manager.close_connection

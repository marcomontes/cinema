require 'sequel'
$DB = Sequel.connect(
  adapter:  :postgres,
  user:     'marcomontes',
  password: '',
  host:     '127.0.0.1',
  port:     '5432',
  database: 'cinema',
  max_connections: 10
)

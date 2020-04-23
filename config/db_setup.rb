require 'sequel'

#DB = Sequel.connect(
#  adapter:  :postgres,
#  user:     'marcomontes',
#  password: '',
#  host:     '127.0.0.1',
#  port:     '5432',
#  database: 'cinema',
#  max_connections: 10
#)

$DB = Sequel.connect(
  adapter:  :postgres,
  user:     'tahahleqbotsay',
  password: '36626f949ef0ad18ef7911a229de433ad274692a569868588ba5c4b555f50ceb',
  host:     'ec2-34-202-7-83.compute-1.amazonaws.com',
  port:     '5432',
  database: 'dfojpg62bhcptq',
  max_connections: 10
)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
require 'db_setup'

Bundler.require :default, ENV['RACK_ENV']

Sequel::Model.plugin :json_serializer

Dir[File.expand_path('../api/*.rb', __dir__)].each do |f|
  require f
end
Dir[File.expand_path('../app/models/*.rb', __dir__)].each do |f|
  require f
end

require 'api'
require 'cinema_app'

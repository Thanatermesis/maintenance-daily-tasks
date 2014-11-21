require 'active_record'
require 'yaml'

dbconfig = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.open('db/database.log', 'w'))
ActiveRecord::Base.establish_connection(dbconfig)

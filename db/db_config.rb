require 'active_record'
require 'yaml'

if $TESTS 
  dbconfig = YAML::load(File.open('config/database-test.yml'))
  ActiveRecord::Base.logger = Logger.new(File.open('db/database-test.log', 'w'))
  puts "DB for testing"
else
  dbconfig = YAML::load(File.open('config/database.yml'))
  ActiveRecord::Base.logger = Logger.new(File.open('db/database.log', 'w'))
end
ActiveRecord::Base.establish_connection(dbconfig)

dbconfig = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'w'))
ActiveRecord::Base.establish_connection(dbconfig)

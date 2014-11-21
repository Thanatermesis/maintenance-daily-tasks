$LOAD_PATH << File.expand_path('../../../config', __FILE__)
$LOAD_PATH << File.expand_path('../../../lib', __FILE__)

require 'yaml'
require 'active_record'

require_relative '../../db/db_config'

# Requires all files .rb in ./app/models 
Dir.glob('./app/models/*.rb').each do |file|
    require file
end
#require_relative '../models/task'

require 'node'

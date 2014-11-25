$TESTS=true
require 'factory_girl'

require 'database_cleaner'

Dir.glob('./spec/support/*.rb').each do |file|
    require file
end

FactoryGirl.find_definitions
$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require_relative '../db/db_config'
$LOAD_PATH << File.expand_path('../../app/models', __FILE__)




require 'node'

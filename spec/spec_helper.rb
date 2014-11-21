$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require_relative '../db/db_config'
$LOAD_PATH << File.expand_path('../../app/models', __FILE__)

require 'node'

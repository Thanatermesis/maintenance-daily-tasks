$LOAD_PATH << File.expand_path('../../../config', __FILE__)


require 'yaml'
require 'active_record'

require_relative '../../db/db_config'
require_relative '../models/task'
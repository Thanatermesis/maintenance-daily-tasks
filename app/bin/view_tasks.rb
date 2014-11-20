puts File.expand_path('../../../config', __FILE__)

require_relative 'app_helper'



task = Task.all
puts task

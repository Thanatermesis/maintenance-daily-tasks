require_relative 'app_helper'

require 'csv'

#customers = CSV.read('customers.csv')

["Task 1", "Task 2"].each do |nombre| 
  unless Task.find_by_name(nombre)
    task = Task.create(:name => nombre)
  end
end

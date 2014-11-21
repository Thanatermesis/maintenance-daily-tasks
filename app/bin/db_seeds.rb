require_relative 'app_helper'

require 'csv'

mantenimiento = CSV.read('app/assets/csv/mantenimiento.csv', headers:true)




mantenimiento.each do |m|
  puts Ficha.get_or_create(m[1])
end


# ["Task 1", "Task 2"].each do |nombre| 
#   unless Task.find_by_name(nombre)
#     task = Task.create(:name => nombre)
#   end
# end

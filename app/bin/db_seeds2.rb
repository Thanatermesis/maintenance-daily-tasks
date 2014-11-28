require_relative 'app_helper'

require 'csv'

mantenimientoCSV = CSV.read('app/assets/csv/acciones.csv')

#Equipo.delete_all
#Mantenimiento.delete_all
mantenimientoCSV.each do |m|
  puts m
  #puts("#{m[1]}, #{m[5]}, #{m[4]}")
end

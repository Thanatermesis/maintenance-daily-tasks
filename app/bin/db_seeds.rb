require_relative 'app_helper'

require 'csv'

mantenimiento = CSV.read('app/assets/csv/mantenimiento.csv', headers:true)

Equipo.delete_all
mantenimiento.each do |m|
  equipo = Equipo.new
  equipo.ficha = Ficha.get_or_create(m[1])
  equipo.save
  mantenimiento = Mantenimiento.new
  
end





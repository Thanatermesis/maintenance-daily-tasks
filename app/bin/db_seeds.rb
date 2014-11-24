require_relative 'app_helper'

require 'csv'

mantenimientoCSV = CSV.read('app/assets/csv/mantenimiento.csv', headers:true)

Equipo.delete_all
Mantenimiento.delete_all
mantenimientoCSV.each do |m|
  ficha = Ficha.get_or_create(m[1])
  equipo = Equipo.new
  equipo.ficha = ficha
  equipo.save
  mantenimiento = Mantenimiento.new
  mantenimiento.ficha = ficha
  mantenimiento.descripcion = m[5]
  puts Hash[Mantenimiento::PERIODICIDAD][m[4]]
  mantenimiento.periodicidad = Hash[Mantenimiento::PERIODICIDAD][m[4]]
  puts mantenimiento
  mantenimiento.save
end





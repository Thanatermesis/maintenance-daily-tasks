require 'date'

require_relative 'app_helper'

require 'csv'

mantenimientoCSV = CSV.read('app/assets/csv/mantenimiento.csv', headers:true)

Equipo.delete_all
Mantenimiento.delete_all
mantenimientoCSV.each do |m|
  ficha = Ficha.get_or_create(m[1])
  equipo = Equipo.new
  equipo.ficha = ficha
  if m[7] and m[7].match(/([0-9]{4,4})-([0-9]{2,2})-([0-9]{1,2})/)
    d = m[7].match(/([0-9]{4,4})-([0-9]{2,2})-([0-9]{1,2})/)
    equipo.instalacion=Date.new($1.to_i,$2.to_i,$3.to_i)
  else
    equipo.instalacion = Date.new(2014,12,15)+rand(60)
  end
  equipo.save
  mantenimiento = Mantenimiento.new
  mantenimiento.ficha = ficha
  mantenimiento.descripcion = m[5]
  mantenimiento.periodicidad = Hash[Mantenimiento::PERIODICIDAD][m[4]]
  mantenimiento.save
end





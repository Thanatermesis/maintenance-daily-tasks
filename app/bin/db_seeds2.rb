require_relative 'app_helper'

require 'csv'

mantenimientoCSV = CSV.read('app/assets/csv/acciones.csv',  headers: true, :col_sep => '|')

fl = true
Ficha.delete_all
Equipo.delete_all
Mantenimiento.delete_all
mantenimientoCSV.each do |m|
  ficha = Ficha.get_or_create(m[1])
  equipo = Equipo.new
  equipo.ficha = ficha
  equipo.instalacion = Date.new(2014,11,15)+rand(30)

end

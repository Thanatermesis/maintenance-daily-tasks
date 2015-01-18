require_relative 'app_helper'

require 'csv'

mantenimientoCSV = CSV.read('app/assets/csv/acciones.csv',  headers: true, :col_sep => '|')

counter = 1
Ficha.delete_all
Equipo.delete_all
Mantenimiento.delete_all
hms = Hash[Mantenimiento::PERIODICIDAD]
mantenimientoCSV.each do |m|
  if !["luxes", ""].include?(m[6])
    puts counter
    counter += 1
    ficha = Ficha.get_or_create(m[1])
    equipo = Equipo.new
    equipo.ficha = ficha
    equipo.instalacion = Date.new(2015,01,01)
    equipo.save
    mantenimiento = Mantenimiento.new
    mantenimiento.ficha = ficha
    mantenimiento.descripcion = m[7]
    mantenimiento.periodicidad = hms[m[6]]
    mantenimiento.save
  end
end

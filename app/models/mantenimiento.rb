class Mantenimiento < ActiveRecord::Base

  PERIODICIDAD = [["Semanal","Sn"], ["Mensual","Ms"], ["Semestral", "Ss"]]
  belongs_to :ficha
  has_many :accions

end

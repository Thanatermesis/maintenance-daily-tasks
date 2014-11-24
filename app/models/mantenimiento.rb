class Mantenimiento < ActiveRecord::Base
  PERIODICIDAD = [["Mensual","Ms"], ["Semestral", "Ss"]]
  belongs_to :ficha
  has_many :accions

  


end

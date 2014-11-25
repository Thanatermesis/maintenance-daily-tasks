class Accion < ActiveRecord::Base
  belongs_to :equipo
  belongs_to :mantenimiento

end

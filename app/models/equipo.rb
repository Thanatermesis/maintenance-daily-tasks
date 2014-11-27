class Equipo < ActiveRecord::Base
  belongs_to :ficha
  has_many :accions

  def mantenimientos
    self.ficha.mantenimientos
  end
  
  def get_actions(mantenimiento)
    self.accions.select{ |a| a.mantenimiento == mantenimiento } 
  end

  def get_last_action(mantenimiento)
    self.get_actions(mantenimiento).sort_by{ |a| a.fecha }.last
  end

  def datetime_of_last_action(mantenimiento)
    a = get_last_action(mantenimiento)
    if a
      a.fecha
    else
      self.instalacion
    end
  end

  def date_of_last_action(mantenimiento)
    self.datetime_of_last_action(mantenimiento).to_date
  end

  def date_of_next_accion(mantenimiento)
    sef.date_of_last_action(mantenimiento) + mantenimiento.waiting_time
  end
end

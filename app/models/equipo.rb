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

  def next_accion(mantenimiento, from=Date.today, till=nil)
    if !till
      till = from
    end
    scheduled = []
    last_date = self.date_of_last_action(mantenimiento)

  end
end

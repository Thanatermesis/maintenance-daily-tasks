class Accion < ActiveRecord::Base
  belongs_to :equipo
  belongs_to :mantenimiento

  def periodicidad
    self.mantenimiento.periodicidad
  end

  def waiting_time
    self.mantenimiento.waiting_time
  end

  def next_action(count=1)
    (1..count).reduce(self.fecha) do |new_fecha, n| 
      new_fecha + Mantenimiento.NEXT_ACTION[self.mantenimiento.periodicidad]
    end
  end
end

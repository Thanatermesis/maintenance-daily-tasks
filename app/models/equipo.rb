class Equipo < ActiveRecord::Base
  belongs_to :ficha
  has_many :accions

  def mantenimientos
    self.ficha.mantenimientos
  end
  
  def add_accion(mantenimiento, ac_fecha = nil)
    if !ac_fecha
      ac_fecha = DateTime.now
    end
    Accion.create(equipo: self, mantenimiento: mantenimiento, fecha: ac_fecha)
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
    self.date_of_last_action(mantenimiento) + mantenimiento.waiting_time
  end

  def self.dates_of_next_accions
    self.all.reduce({}) do |he,e|
      he[e] = e.mantenimientos.reduce({}) do | hm, m |
        hm[m]=e.date_of_next_accion(m)
        hm
      end
      he
    end
  end

  def self.pending_accions(date)
    nas = self.dates_of_next_accions
    nas.keys.reduce({}) do |he,e|
      he_temp = nas[e].keys.reduce({}) do | hm, m |
        hm[m]=nas[e][m] if nas[e][m]<date
        hm
      end
      he[e] = he_temp if he_temp != {}
      he
    end 
  end
end

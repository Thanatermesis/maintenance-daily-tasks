class Equipo < ActiveRecord::Base
  belongs_to :ficha
  has_many :accions

  def mantenimientos
    self.ficha.mantenimientos
  end
end

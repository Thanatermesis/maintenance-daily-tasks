class Ficha < ActiveRecord::Base
  has_many :equipos
  has_many :mantenimientos
  validates :nombre, uniqueness: true

  def self.get_or_create(nombre)
    ficha = self.find_by_nombre(nombre)
    if not ficha
      ficha = self.create(nombre:nombre)
    end
    return ficha
  end


end

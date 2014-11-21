class Ficha < ActiveRecord::Base

  def self.get_or_create(nombre)
    ficha = self.find_by_nombre(nombre)
    if not ficha
      ficha = self.create(nombre:nombre)
    end
    return ficha
  end


end

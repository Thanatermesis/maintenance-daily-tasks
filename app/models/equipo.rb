class Equipo < ActiveRecord::Base
  belongs_to :ficha
  has_many :accions
end

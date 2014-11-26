class Mantenimiento < ActiveRecord::Base

  PERIODICIDAD = [["Semanal","semanal"], ["Mensual","mensual"], ["Semestral", "semestral"]]

  NEXT_ACTION = {"semanal"=> 1.week, "mensual"=> 1.month, "semestral" => 6.months}


  belongs_to :ficha
  has_many :accions

  def waiting_time
    NEXT_ACTION[self.periodicidad]
  end
end

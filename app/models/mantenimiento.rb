class Mantenimiento < ActiveRecord::Base

  PERIODICIDAD = [["Diario", "diario"],["Semanal","semanal"], 
                  ["Mensual","mensual"], ["Bimensual", "bimensual"],
                  ["Semestral", "semestral"], ["Anual","anual"]]

  NEXT_ACTION = {"diario"=>1.day, "semanal"=> 1.week, "mensual"=> 1.month, 
                 "bimensual"=> 2.months, "semestral" => 6.months,
                "anual" => 1.year }


  belongs_to :ficha
  has_many :accions

  def waiting_time
    NEXT_ACTION[self.periodicidad]
  end
end

FactoryGirl.define do
  
  factory :equipo do 
    ficha
    instalacion {Date.new(2014,1,1) + rand(100)}
  end

  factory :mantenimiento do 
    ficha
    descripcion { "lavar tapa #{rand(10000)}" }
    periodicidad "mensual"
  end

  factory :accion do 
    equipo
    mantenimiento
    fecha {Date.new(2014,5,1) + rand(100)}
  end

  factory :ficha do
    sequence :nombre do |n|
      "Ficha nr #{n}"
    end
    
    factory :ficha_with_equipos do
      transient do
        equipos_count 3
      end

      after(:create) do |ficha, evaluator|
        create_list(:equipo, evaluator.equipos_count, ficha: ficha)
      end

      factory :ficha_with_equipos_and_mantenimientos do 
        transient do
          mantenimientos_count 2
        end

        after(:create) do |ficha, evaluator|
          create_list(:mantenimiento, evaluator.mantenimientos_count, ficha: ficha)
        end
      end
    end

    factory :ficha_with_mantenimientos do
      transient do
        mantenimientos_count 3
      end

      after(:create) do |ficha, evaluator|
        create_list(:mantenimiento, evaluator.mantenimientos_count, ficha: ficha)
      end
    end
    
  end

end

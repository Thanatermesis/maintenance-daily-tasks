ActiveRecord::Schema.define do

  create_table :fichas do |table|
    table.column :nombre, :string
  end

  create_table :equipos do |table|
    table.column :ficha_id, :integer
    table.column :instalacion, :date
  end

  create_table :mantenimientos do |table|
    table.column :ficha_id, :integer
    table.column :descripcion, :text
    table.column :periodicidad, :string
  end

  create_table :accions do |table|
    table.column :mantenimiento_id, :integer
    table.column :equipo_id, :integer
    table.column :fecha, :datetime
  end

end


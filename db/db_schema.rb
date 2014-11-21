ActiveRecord::Schema.define do

  create_table :fichas do |table|
    table.column :nombre, :string
  end

  create_table :equipos do |table|
    table.column :ficha_id, :integer
  end

  create_table :mantenimientos do |table|
    table.column :equipo_id, :integer
    table.column :peridicidad, :string
  end

end


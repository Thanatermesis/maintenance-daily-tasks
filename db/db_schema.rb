require_relative 'db_config'

ActiveRecord::Schema.define do
  create_table :tasks do |table|
    table.column :name, :string
  end
end

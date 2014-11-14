require 'active_record'

ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'w'))

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'hospital.db'
)

ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'tasks'
    create_table :tasks do |table|
      table.column :name, :string
    end
  end
end

class Task < ActiveRecord::Base
end

["Task 1", "Task 2"].each do |nombre| 
  unless Task.find_by_name(nombre)
    task = Task.create(:name => nombre)
  end
end


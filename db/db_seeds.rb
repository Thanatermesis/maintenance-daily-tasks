require_relative '../../app/models/task'

["Task 1", "Task 2"].each do |nombre| 
  unless Task.find_by_name(nombre)
    task = Task.create(:name => nombre)
  end
end

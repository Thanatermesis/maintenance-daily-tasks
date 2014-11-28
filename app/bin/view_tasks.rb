require_relative 'app_helper'

# tasks = Task.all
# fichas = Ficha.all
# equipos = Equipos.all

# win = Window.new({xsize:500})
# glist  = GenList.new(win)

# tasks.each do |t|
#   GenListItem.new(glist, {text: t.name, icon: "home"})
# end

# win.e_exec



tasks = Equipo.pending_accions(DateTime.now+2.years)
#p tasks

win = Window.new({xsize:500})
glist  = GenList.new(win)

tasks.keys.each do |e|
  tasks[e].keys.each do |m|
    GenListItem2.new(glist, { text: "#{e.ficha.nombre}: #{m.descripcion}", icon: "home"})
  end
end

win.e_exec

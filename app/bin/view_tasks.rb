require_relative 'app_helper'


tasks = Equipo.pending_accions(DateTime.now)


win = Window.new({xsize:500})
list  = List.new(win)

tasks.keys.each do |e|
  tasks[e].keys.each do |m|
    button = Button.new({text: "A tomar por ...", action: nil})
    entry = ListItem.new(glist, { text: "#{e.ficha.nombre}: #{m.descripcion}", buttonleft: button})
  end
end

#Accion.new
win.e_exec

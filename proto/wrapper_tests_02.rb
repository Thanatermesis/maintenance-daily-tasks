#!/usr/bin/env ruby

require_relative 'proto_helper'

win = Window.new({xsize:500})
win.title="Ala ma kota"
win.ysize=500

win.add_task(1.0) do |x| 
  win.title = "BBB" 
  win.e_title
end

win.add_task(2.0) do |x| 
  evas_object_move(win.e_win, 200, 200)
end

win.add_task(3.0) do |x|
  puts win.e_position_get
end


button = Button.new(win, {text: "AAAA", x: 200}) 

button.add_action("clicked") do
  puts "GGGGGGGG"
end
# end

win.e_exec

#win.e_vamos_por_todo





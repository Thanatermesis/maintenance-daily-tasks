#!/usr/bin/env ruby

require_relative 'proto_helper'

win = Window.new({xsize:500})

glist  = GenList.new(win)
GenListItem.new(glist, {text: "AAAAA", icon: "home"})
GenListItem.new(glist, {text: "BBB", icon: "clock"})



win.add_task(1.0) do |x| 
  entry=GenListItem.new(glist, {text: "CCC"})
  entry.e_init

end


win.e_exec


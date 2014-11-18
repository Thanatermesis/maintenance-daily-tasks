#!/usr/bin/env ruby

require 'efl/native/elm/elm_win'
require 'efl/native/elm/elm_bg'
require 'efl/native/elm/elm_button'
require 'efl/native/elm/elm_check'
require 'efl/native/elm/elm_object'
require 'efl/native/elm/elm_focus'

require 'efl/native/ecore'

include Efl::Native

class Window
  attr_reader :e_win

  def initialize(specs={})
    @specs = { app_name: "AppName", title: "Title", xsize: 200, ysize: 100  }
    @tasks = []
    @children = []
    @specs.each do |k,v|
      @specs[k] = specs[k] if specs.include?(k)
    end
  end

  def add_child(child)
    puts "Adds Child"
    @children << child
  end
  def title=(title)
    @specs[:title]=title
  end

  def xsize=(x)
    @specs[:xsize]=x
  end

  def ysize=(y)
    @specs[:ysize]=y
  end

  def add_task(time, &block)
    task = (lambda &block)
    @tasks << [time, task]
  end

  def e_init
    elm_init(0, nil)
    @e_win = elm_win_add(nil, @specs[:app_name], 0)
    elm_win_autodel_set(@e_win, true)
    elm_policy_set( 
      Efl::Native.enum_type(:elm_policy)[:elm_policy_quit], 
      Efl::Native.enum_type(:elm_policy_quit)[:elm_policy_quit_last_window_closed])
    elm_object_focus_set(@e_win, true)
    self
  end

  def e_title()
    elm_win_title_set(@e_win, @specs[:title] )
    self
  end

  def e_resize
    evas_object_resize(@e_win, @specs[:xsize], @specs[:ysize] )
    self
  end

  def e_run_after(secs, task)
    ecore_timer_add(secs, task, nil)
  end

  def e_prepare_tasks
    @tasks.each do |secs, task|
      e_run_after(secs, task)
    end
  end

  def e_show
    evas_object_show(@e_win)
    bg = elm_bg_add(@e_win)
    evas_object_size_hint_weight_set(bg, 1.0, 1.0)
    elm_win_resize_object_add(@e_win, bg)
    evas_object_show(bg)
    @children.each { |c| c.e_init }
    self
  end
  
  def e_update
    e_title
    e_resize
  end

  def e_init_children
    @children.each { |c| c.e_init }
  end

  def e_exec
    e_init
    e_update
    e_prepare_tasks
    e_init_children
    e_show
    elm_run
    e_shutdown
  end

  def e_shutdown
    elm_shutdown
  end

  def e_position_get
    x = FFI::MemoryPointer.new :int
    y = FFI::MemoryPointer.new :int
    elm_win_screen_position_get @win, x, y
    [ x.read_int, y.read_int ]
  end

  
end

class Widget
  attr_reader :window
  attr_reader :e_widget

  
  def initialize(parent=nil, specs= {})
    @window = parent
    @actions = []
    @specs = specs
    @e_widget = nil
    if @window
      @window.add_child(self)
    end
  end
  
  def add_to(window)
    @window = window
    @window.add_child(self)
  end

end

class Button < Widget

  def e_init
    @e_widget = elm_button_add(@window.e_win)
    elm_object_part_text_set(@e_widget, nil, @specs[:text])
    @actions.each do |action, method|
      evas_object_smart_callback_add(@e_widget, action, method, nil)
    end
    evas_object_resize(@e_widget, 120, 30)
    evas_object_move(@e_widget, 60, 15)
    evas_object_show(@e_widget)
  end

  def add_action(action, &block)
    method = (lambda &block)
    @actions << [action, method]
  end

end

win = Window.new({xsize:1000})
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


puts "Hello"


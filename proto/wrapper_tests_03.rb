#!/usr/bin/env ruby

# This version of prototypes is meant to be a simplest-possible one

require 'efl/native/elm/elm_win'
#require 'efl/native/elm/elm_bg'
#require 'efl/native/elm/elm_check'
require 'efl/native/elm/elm_object'
require 'efl/native/elm/elm_focus'

require 'efl/native/ecore'

include Efl::Native




class Window

  attr_accessor :title, :x, :y, :text

  def initialize
    # initialize framework
    elm_init(0, nil)

    # defalut generic values that can be changed later
    @x = 200
    @y = 100
    #@title = "Title"
    @app = "Application"

    # create a new window object
    @win = elm_win_add(nil, @app, 0)

    # default parameters of a normal app
    elm_win_autodel_set(@win, true)
    elm_policy_set( Efl::Native.enum_type(:elm_policy)[:elm_policy_quit], Efl::Native.enum_type(:elm_policy_quit)[:elm_policy_quit_last_window_closed])
    elm_object_focus_set(@win, true)

    # set default settings
    self.resize
    self.title
  end

  def run
    elm_run
    elm_shutdown
  end

  def title_set(title="Title")
    @title = title
    elm_win_title_set(@win, @title)
    self.show
    self
  end

  def title=(*args)
    title_set(*args)
  end

  def title_get
    #elm_win_title_get(@win)
    @title
  end

  def resize
    evas_object_resize(@win, @x, @y)
    self
  end


  def show
    evas_object_show(@win)
    self
  end

  def position
    #x, y = elm_win_screen_position_get(win)
    evas_object_move(@win, 229, 50)

    x = FFI::MemoryPointer.new :int
    y = FFI::MemoryPointer.new :int
    elm_win_screen_position_get @win, x, y
    puts [ x.read_int, y.read_int ]
  end

  def button_add=(text)
    @btn = elm_button_add(@win)
    elm_object_part_text_set(@btn, nil, text)
    evas_object_smart_callback_add(@btn, "clicked", method(:on_click), nil)
    evas_object_resize(@btn, 120, 30)
    evas_object_move(@btn, 60, 15)
    evas_object_show(@btn)
  end

end




#

win = Window.new


#win.title("Ala ma kota").show
win.title_set("bar")
win.title = "foo"


#win.button_add
win.button_add("mybutton")

#puts win.title_get
puts win.title
#win.position


win.run


#win.show.run


# vim: autoindent tabstop=2 shiftwidth=2 expandtab softtabstop=2 filetype=ruby
#

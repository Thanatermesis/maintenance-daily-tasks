#!/usr/bin/env ruby

require 'efl/native/elm/elm_win'
require 'efl/native/elm/elm_bg'
require 'efl/native/elm/elm_button'
require 'efl/native/elm/elm_check'
require 'efl/native/elm/elm_object'
require 'efl/native/elm/elm_focus'
require 'efl/native/elm/elm_label'
require 'efl/native/elm/elm_genlist'


require 'efl/native/ecore'

include Efl::Native

class Node
  attr_reader :children

  def initialize(specs={})
    @specs = {}
    specs.each{ |k,v| @specs[k] = specs[k] }
    @children = []        
  end

  def add_child(child)
    @children << child
  end

  def parent
    @specs[:parent]
  end
  
  def parent=(new_parent)
    @specs[:parent]=new_parent
  end

  def add_to(new_parent)
    self.parent= new_parent
    parent.add_child(self)
  end


end

class Window < Node

  attr_reader :e_win

  def initialize(specs={})
    @specs = { app_name: "AppName", title: "Title", xsize: 200, ysize: 100  }
    @tasks = []
    super(specs)
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
    task = lambda(&block)
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

class Widget < Node 
  attr_reader :e_widget

  def initialize(new_parent=nil, specs= {})
    @actions = []
    @specs = specs
    @e_widget = nil
    add_to(new_parent) if new_parent
    super(specs)
  end

end

class Button < Widget

  def e_init
    @e_widget = elm_button_add(parent.e_win)
    elm_object_part_text_set(e_widget, nil, @specs[:text])
    @actions.each do |action, method|
      evas_object_smart_callback_add(@e_widget, action, method, nil)
    end
    evas_object_resize(@e_widget, 120, 30)
    evas_object_move(@e_widget, 60, 15)
    evas_object_show(@e_widget)
  end

  def add_action(action, &block)
    method = lambda(&block)
    @actions << [action, method]
  end

end




class ElmGenItemClass < FFI::Struct
  layout  :version, :int,
  :refcount, :uint,
  :delete_me, :pointer,
  :item_style, :pointer,
  :decorate_item_style, :pointer,
  :decorate_all_item_style, :pointer,
  :text_get, :pointer,
  :content_get, :pointer,
  :state_get, :pointer,
  :del, :pointer
end


class GenList < Widget

  def entries
    @specs[:entries]
  end

  def e_init
    @e_widget = elm_genlist_add(parent.e_win)
    self.children.each do |entry|
      entry.e_init
    end
    evas_object_size_hint_weight_set(@e_widget, 1.0, 1.0)
    elm_win_resize_object_add(parent.e_win, @e_widget)
    e_show
  end

  def e_show
    evas_object_show(@e_widget)
  end
end


class GenListItem < Widget

  def text
    @specs[:text]
  end

  def e_init
    if !@itc
      itc_ptr = elm_genlist_item_class_new
      @itc = ElmGenItemClass.new(itc_ptr)
      @itc[:item_style] = FFI::MemoryPointer.from_string("default")
      @itc[:text_get] = 
        FFI::Function.new(:pointer, [:pointer, :pointer, :string]) { |data, *_|
        ptr = FFI::MemoryPointer.from_string("XXX #{data.read_string}")
        ptr.autorelease = false
        ptr
      }
      if @specs[:icon] 
        @itc[:content_get] = 
          FFI::Function.new(:pointer, [:pointer, :pointer, :string]) do
          |data, obj, part|
          ic = elm_icon_add(obj)
          elm_icon_standard_set(ic, @specs[:icon])  if part == "elm.swallow.icon"
          evas_object_size_hint_aspect_set(ic, 0, 1, 1)
          ic
        end
      end
      @itc[:state_get] = nil
      @itc[:del] = nil
    end

    elm_genlist_item_append(
       parent.e_widget, @itc, self.text, nil, :elm_genlist_item_none,
       FFI::Function.new(:pointer, [:pointer, :pointer, :pointer]) {|data, obj, evt|
         p [:selected, data.read_string] }, self.text)
  end
end

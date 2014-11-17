#!/usr/bin/env ruby

require 'efl/native/elm/elm_win'
#require 'efl/native/elm/elm_bg'
#require 'efl/native/elm/elm_check'
require 'efl/native/elm/elm_object'
require 'efl/native/elm/elm_focus'

require 'efl/native/ecore'

include Efl::Native




class Window

    def initialize(specs={})
        @specs = { app_name: "AppName", title: "Title", x: 200, y: 100  }
        @specs.each do |k,v|
            @specs[k] = specs[k] if specs.include?(k)
        end
    end

    def title=(title)
      @specs[:title]=title
    end

    def x=(x)
      @specs[:x]=x
    end

    def y=(y)
      @specs[:y]=y
    end

    def e_init
      elm_init(0, nil)
      @win = elm_win_add(nil, @specs[:app_name], 0)
      elm_win_autodel_set(@win, true)
      elm_policy_set( Efl::Native.enum_type(:elm_policy)[:elm_policy_quit], Efl::Native.enum_type(:elm_policy_quit)[:elm_policy_quit_last_window_closed])
      elm_object_focus_set(@win, true)
      self
    end

    def e_title()
      elm_win_title_set(@win, @specs[:title] )
      self
    end

    def e_resize
      evas_object_resize(@win, @specs[:x], @specs[:y] )
      self
    end

    def e_show
      evas_object_show(@win)
      self
    end

    def testaction(pwin)
      self.title= "AAAAA"
      self.e_title
    end

    def run_after(method, secs)
      ecore_timer_add(secs, method, nil)
    end



    def e_vamos_por_todo
      e_init
      e_title
      e_resize
      run_after(lambda { |x| puts "BBB"}, 1.0)
      e_show
      elm_run
      e_shutdown
    end

    def e_shutdown
      elm_shutdown
    end
end

#

win = Window.new({x:1000})
win.title="Ala ma kota"
win.y=500


win.e_vamos_por_todo


puts "Hello"


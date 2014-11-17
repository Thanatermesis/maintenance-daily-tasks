#!/usr/bin/env ruby

require "efl/elm/elm_win"
require 'efl/ecore'
include Efl

#require 'efl/native/ecore'
#include Efl::Native
#include Efl::Native


module Rgui

    class Window < Elm::ElmWin
        # headers
        #attr_accessor :title
      attr_reader :title

        def initialize(specs)
            @title = "Default"
            specs.each do  |k,v|
              #self.method(k.to_s+"=").call(v) if respond_to? (k.to_s+"=").to_sym
              if respond_to?(k.to_s+"=")
                  self.method(k.to_s+"=").call(v)
              else
                  puts "W: unkown key #{k}"
              end
            end

            Elm.init
            #puts "created"
            super(nil, "Greetings") do
                title_set
                autodel_set true
                resize 240, 60
                show
            end

            Elm.elm_policy_set(0, 1)
        end

        def title_set
          elm_win_title_set title
        end

        def title=title
            @title = title
            title_set
        end

        def run
            Elm.run
        end

        def shutdown
            Elm.shutdown
        end
    end

end

class Window2
  # headers
  #attr_accessor :title
  attr_reader :title


  def initialize()
    @win = elm_win_add(nil, "AppName", 0)
  end
end



#win = Rgui::Window.new
win = Rgui::Window.new( title: "hello", dupa: "problems")
# goal 1: change the title after passed 1 second



#
# BUG !!!
#
# we are unable to use the ecore part easly from here, it is the wrapper (not native) already set for it ? mmmh, brainstorming to use native directly instead, continuing in the next experiment!
#
#def cb_change_text
    #win.title = "this is my title"
#end
#Ecore.timer_add(1.0, method(:cb_change_text), win)
# win.ecore_timer_add do
#     puts "hi"
# end

 win.run
 win.shutdown

# #
# #



exit


# Project: make a GUI ruby syntax as much simpler as possible,check out the examples from:  http://code-monkey.de/pages/ruby-efl
#

# GOAL 1:  use windows, context, buttons, and tooltips, play with this

# EXAMPLE GOAL 1 SYNTAX:

# Action: create a window
win = Rgui.new

# Action: set the title
win.title = "Amazing Application"

#
# SYNTAX BRAINSTORM
#
# Action: append a button
button_ok = add_button(win, icon: "OK", text: "Continue") # first param should be always the target, other args are optional

edje.on_signal("QUIT", "*") do
    Ecore::main_loop_quit
end

# evaluate something from ruby code:
seconds = 5
text = "Continue in #{seconds} seconds"

# Action: change button text
# and now that we have it evaluated from our ruby code, change the button text
button_ok.text = text

# Action: tooltip on specific target
# ok so, we want to add a tooltip in a specific target (the button), what is the best way to do it? like our first or second button example ?


# show the window here
win.show



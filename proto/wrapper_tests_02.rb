#!/usr/bin/env ruby

require 'efl/native/elm/elm_win'
#require 'efl/native/elm/elm_bg'
#require 'efl/native/elm/elm_check'
#require 'efl/native/elm/elm_object'
#require 'efl/native/elm/elm_focus'

require 'efl/native/ecore'

include Efl::Native

elm_init 0, nil


class Window
    # headers
    #attr_accessor :title
    attr_reader :title


    def initialize()
        @win = elm_win_add(nil, "AppName", 0)
        evas_object_show(@win)
    end
end

win = Window.new



elm_run
elm_shutdown




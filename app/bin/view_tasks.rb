#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
#
require_relative 'app_helper'
#
require 'efl/elm/elm_win'
require 'efl/elm/elm_icon'
require 'efl/elm/elm_button'
require 'efl/elm/elm_object'
require 'efl/elm/elm_bg'
require 'efl/elm/elm_list'
#
include Efl::Native



elm_init 0, FFI::MemoryPointer::NULL

win = elm_win_add(nil, "list button", 0)
elm_win_title_set(win, "ListButton")
elm_policy_set(0, 1)
elm_win_autodel_set(win, true)

bg = elm_bg_add(win)
elm_bg_color_set(bg, 255, 255, 255)
evas_object_size_hint_weight_set(bg, 1.0, 1.0)
elm_win_resize_object_add(win, bg)
evas_object_show(bg)

li = elm_list_add(win)
evas_object_size_hint_weight_set(li, 1.0, 1.0)
elm_win_resize_object_add(win, li)
elm_list_mode_set(li, 1)
evas_object_show(li)

#ic = elm_icon_add(win)
#snprintf(buf, sizeof(buf), "%s/images/logo_small.png", elm_app_data_dir_get())
#elm_image_resizable_set(ic, EINA_FALSE, EINA_FALSE)
#elm_image_file_set(ic, buf, NULL)



tasks = Equipo.pending_accions(Date.today)
#p tasks

tasks.keys.each do |e|
  tasks[e].keys.each do |m|

    #def button_clicked data, object, event, target
      #e.add_action(m)
      #p data
      #p object
      #p event
      #p target
    #end

    eval %Q{
    def bt_clicked_#{e.id}_#{m.id} data, object, event
      puts "button clicked #{e.id} #{m.id}"
      equipo = Equipo.find(#{e.id})
      mantenimiento = Mantenimiento.find(#{m.id})
      puts equipo.datetime_of_last_action(mantenimiento)
      equipo.add_accion(mantenimiento)
      puts equipo.datetime_of_last_action(mantenimiento)
    end
    }

    def it_clicked data, object, event
      puts "item clicked 2"
    end


    #entry = GenListItem.new(glist, { text: "#{e.ficha.nombre}: #{m.descripcion}", icon: "home", button: "wombat"})
    ic2 = elm_button_add(win)
    elm_object_part_text_set(ic2, nil, "Tarea Completada")
    evas_object_smart_callback_add(ic2, "clicked", method("bt_clicked_#{e.id}_#{m.id}".to_sym), nil)
    #evas_object_smart_callback_add(ic2, "clicked", method(:button_clicked, nil)
    evas_object_propagate_events_set(ic2, false)
    elm_list_item_append(li, "#{e.ficha.nombre}: #{m.descripcion} | Ubicación: (null)", nil, ic2, method(:it_clicked), nil)
    evas_object_show(ic2)

    #e.add_action(m)
  #def add_accion(mantenimiento, ac_fecha = nil)

    #entry.add_action("clicked") do |a|
      #puts "#{m.descripcion}"
    #end
  end
end




evas_object_resize(win, 700, 760)
evas_object_show(win)

elm_run
elm_shutdown


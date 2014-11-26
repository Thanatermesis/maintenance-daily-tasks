require_relative '../spec_helper'

RSpec.describe Equipo do

  let(:accion) { FactoryGirl.create(:accion) }
  let(:mantenimiento) { FactoryGirl.create(:mantenimiento, periodicidad: "semanal") }
  let(:mantenimiento2) { FactoryGirl.create(:mantenimiento, periodicidad: "semestral") }
  let(:mantenimiento3) { FactoryGirl.create(:mantenimiento, periodicidad: "anual") }
  let(:equipo2) { FactoryGirl.create(:equipo, instalacion: Date.new(2012,1,1)) }
  before {
    @accion2 = 
      FactoryGirl.create(:accion, 
        equipo: equipo2, mantenimiento: mantenimiento, fecha:Date.new(2012,02,01)) 
    @accion3 = Accion.create(equipo: equipo2, mantenimiento: mantenimiento2) 
  }
  
  describe "accions" do 
    it "is expected to be an element of its equipo.accions" do 
      expect(equipo2.accions.length).to be(2)
    end
  end
 
  describe "periodicidad de una accion" do
    it "accion should have periodicidad of mantenimiento" do
      expect(accion.periodicidad).to eq("mensual")
      expect(@accion2.periodicidad).to eq("semanal")
      expect(@accion3.periodicidad).to eq("semestral")
    end
  end

  describe "#get_actions" do
    it "is expected to be a list with one action being the 'accion'" do 
      expect(equipo2.get_actions(mantenimiento)).to  contain_exactly(@accion2)
    end
  end

  describe "#get_last_action" do 
    it "is expected to have action as last accion" do 
      @accion22 = FactoryGirl.create(:accion, 
         equipo: equipo2, mantenimiento: mantenimiento, fecha:Date.new(2012,03,01)) 
      expect(equipo2.get_actions(mantenimiento)).to  contain_exactly(@accion2, @accion22)
      expect(equipo2.get_last_action(mantenimiento)).to eq(@accion22)
    end
  end

  describe "date_of_last_action" do 
    before {
      @accion22 = 
        FactoryGirl.create(:accion, 
           equipo: equipo2, mantenimiento: mantenimiento, fecha:DateTime.new(2012,03,01,12,30)) 
    }
    it "is expected to have last accion date well defined" do 
      expect(equipo2.datetime_of_last_action(mantenimiento)).to  eq(DateTime.new(2012,03,01,12,30))
      expect(equipo2.date_of_last_action(mantenimiento)).to  eq(Date.new(2012,03,01))
    end
    it "is expected to return instalacion date if no accions assosiated" do 
      expect(equipo2.date_of_last_action(mantenimiento3)).to  eq(Date.new(2012,03,01))
    end
  end

  describe "#next_action" do 
    
  end
    # describe "Accion#next_action" do
    #   it "is expect to have next mantenimiento en una semana" do 
    #     expect(accion.next_action).to eq(accion.fecha+1.week)
    #   end
    #   it "is expect to have otro en dos semana" do 
    #     expect(accion.next_action(2)).to eq(accion.fecha+2.week)
    #   end
      
    # end
    
end


require_relative '../spec_helper'

RSpec.describe Equipo do

  let(:accion) { FactoryGirl.create(:accion) }
  let(:mantenimiento) { FactoryGirl.create(:mantenimiento, periodicidad: "semanal") }
  let(:mantenimiento2) { FactoryGirl.create(:mantenimiento, periodicidad: "semestral") }
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
      expect(equipo2.datetime_of_last_action(mantenimiento)).
        to  eq(DateTime.new(2012,03,01,12,30))
      expect(equipo2.date_of_last_action(mantenimiento)).
        to  eq(Date.new(2012,03,01))
    end
    it "is expected to return instalacion date if no accions assosiated" do 
      @equipo = FactoryGirl.create(:equipo, instalacion: Date.today+rand(200))
      @mantenimiento3 =FactoryGirl.create(:mantenimiento, periodicidad: "anual") 
      expect(@equipo.date_of_last_action(@mantenimiento3)).
        to  eq(@equipo.instalacion)
    end
  end

  describe "#date_of_next_action" do 
    before {
      @equipo = FactoryGirl.create(:equipo, instalacion: Date.today+rand(200))
      @mantenimiento3 =FactoryGirl.create(:mantenimiento, periodicidad: "anual") 
    }

    it "is expected to return date #instalacion + 1.year, if no accions associated" do 
       expect(@equipo.date_of_next_accion(@mantenimiento3)).
        to  eq(@equipo.instalacion+1.year)
    end

    it "is expected to return date of last accion +1 year" do 
      @fecha1 = Date.today+1.year+rand(50)
      @fecha2 = @fecha1+1.year+rand(50)
      @accion31 = FactoryGirl.create(:accion, 
          {equipo: @equipo, 
           mantenimiento: @mantenimiento3, 
           fecha: @fecha1})
      @accion32 = FactoryGirl.create(:accion, 
          {equipo: @equipo, 
           mantenimiento: @mantenimiento3, 
           fecha: @fecha2})

       expect(@equipo.date_of_next_accion(@mantenimiento3)).
        to  eq(@fecha2+1.year)
    end

  end
    
end


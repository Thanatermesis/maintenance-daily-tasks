require_relative '../spec_helper'

RSpec.describe Equipo do
  let(:ficha1) { FactoryGirl.create(:ficha) }
  let(:ficha2) { FactoryGirl.create(:ficha) }

  before {
    @mantenimiento11 = FactoryGirl.create(:mantenimiento, ficha: ficha1, periodicidad: "semanal") 
    @mantenimiento12 = FactoryGirl.create(:mantenimiento, ficha: ficha1, periodicidad: "semestral") 
    @mantenimiento2 =FactoryGirl.create(:mantenimiento, ficha: ficha2, periodicidad: "semestral") 
    @equipo1 = FactoryGirl.create(:equipo, ficha: ficha1, instalacion: Date.new(2012,1,1)) 
    @equipo2 = FactoryGirl.create(:equipo, ficha: ficha2, instalacion: Date.new(2012,2,1)) 
  }
  describe ".dates_of_next_accions" do
    context "no accion given" do
      it "creates hash" do
        hes =Equipo.dates_of_next_accions
        expect(hes.keys).to contain_exactly(@equipo1, @equipo2)
        expect(hes).to eq({ @equipo1=> 
                           {@mantenimiento11=> Date.new(2012,1,1)+1.week, @mantenimiento12=> Date.new(2012,1,1)+6.months}, 
                         @equipo2 => {@mantenimiento2=> Date.new(2012,2,1)+6.months }})
      end
    end
    context "con acciones" do
      it "creates hash" do
        @fecha11 = Date.new(2012,1,2) + rand(10)
        @fecha2 = Date.new(2012,2,1) + 100 + rand(10)
        @accion11 = FactoryGirl.create(:accion, 
                                       {equipo: @equipo1, 
                                        mantenimiento: @mantenimiento11, 
                                        fecha: @fecha11})
        @accion2 = FactoryGirl.create(:accion, 
                                       {equipo: @equipo2, 
                                        mantenimiento: @mantenimiento2, 
                                        fecha: @fecha2})
        hes =Equipo.dates_of_next_accions
        expect(hes.keys).to contain_exactly(@equipo1, @equipo2)
        expect(hes).to eq({ @equipo1=> 
                           {@mantenimiento11=> @fecha11+1.week, @mantenimiento12=> Date.new(2012,1,1)+6.months}, 
                         @equipo2 => {@mantenimiento2=> @fecha2+6.months }})
      end
    end
  end
  describe ".pending_accions" do
    context "no accion given" do
      it "its creates hash with two keys" do
        hes = Equipo.pending_accions(Date.new(2012,12,1))
        expect(hes.keys).to contain_exactly(@equipo1, @equipo2)
        expect(hes).to eq({ @equipo1 => {@mantenimiento11=> Date.new(2012,1,1)+1.week, @mantenimiento12=> Date.new(2012,1,1)+6.months}, 
                         @equipo2 => {@mantenimiento2=> Date.new(2012,2,1)+6.months }})
      end
      context "date that there is no accion" do
        it "its creates empty hash" do
          hes = Equipo.pending_accions(Date.new(2012,1,1))
          expect(hes).to eq({})
        end
      end
    end
    
  end
end

require_relative '../spec_helper'

require 'ficha'
require 'equipo'


describe Equipo do 

  context "nuevo" do 
    let(:equipo) { Equipo.create }
    subject { equipo }
    it { is_expected.to respond_to(:ficha, :instalacion, :accions, :mantenimientos) }


    describe "#add_accion" do 
      let(:mantenimiento) { FactoryGirl.create(:mantenimiento) }
      it "is expected to add accion" do 
        accion = equipo.add_accion(mantenimiento)
        expect(equipo.accions).to include(accion)
      end
      it "is expected to add accion with special date" do 
        fecha = Date.new(2015,1,1)
        accion = equipo.add_accion(mantenimiento, fecha)
        expect(accion.fecha).to eq(fecha)
        expect(equipo.accions).to include(accion)
      end
    end

  end
end

describe "ficha con equipos" do
  context "con 3 equipos" do 
    let(:ficha) { FactoryGirl.create(:ficha_with_equipos) }
    subject { ficha }
    it "should have 3 equipos" do 
      expect(ficha.equipos.length).to be(3)
    end
  end

  context "con 10 equipos" do 
    let(:ficha) { FactoryGirl.create(:ficha_with_equipos, equipos_count: 10) }
    subject { ficha }
    it "should have 10 equipos" do 
      expect(ficha.equipos.length).to be(10)
    end
  end

end

require_relative '../spec_helper'

RSpec.describe Equipo do

  let(:mantenimiento1) { FactoryGirl.create(:mantenimiento, periodicidad: "semanal") }
  let(:mantenimiento2) { FactoryGirl.create(:mantenimiento, periodicidad: "semestral") }
  let(:mantenimiento3) { FactoryGirl.create(:mantenimiento, periodicidad: "semestral") }
  let(:equipo1) { FactoryGirl.create(:equipo, instalacion: Date.new(2012,1,1)) }
  let(:equipo2) { FactoryGirl.create(:equipo, instalacion: Date.new(2012,2,1)) }
  describe "#schedule" do 
    
  end
end

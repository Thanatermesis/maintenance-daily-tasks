require_relative '../spec_helper'

require 'ficha'
require 'accion'

describe Accion do 
  let(:accion) { FactoryGirl.create(:accion) }
  let(:mantenimiento) { FactoryGirl.create(:mantenimiento, periodicidad: "semanal") }
  let(:mantenimiento2) { FactoryGirl.create(:mantenimiento, periodicidad: "semestral") }
  let(:equipo2) { FactoryGirl.create(:equipo) }
  let(:accion2) { 
    FactoryGirl.create(:accion, equipo: equipo2, mantenimiento: mantenimiento) }
  let(:accion3) { 
    FactoryGirl.create(:accion, equipo: equipo2, mantenimiento: mantenimiento2) }
  subject { accion2 }
  it { is_expected.to respond_to(:equipo, :mantenimiento, :waiting_time)}
  it "is expected to be an element of its equipo.accions" do 
    expect(subject.equipo.accions).to include(subject)
    expect(equipo2.accions).to include(accion2)
    expect(equipo2.accions).to include(accion3)
    expect(equipo2.accions.to_a.length).to be(2)
    expect(accion2.equipo.accions).not_to include(accion)
  end
  it "is expected to wait 1 week" do 
    expect(accion2.waiting_time).to eq(1.week)
  end
end

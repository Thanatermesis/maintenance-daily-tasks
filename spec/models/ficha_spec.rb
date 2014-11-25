require_relative '../spec_helper'

require 'ficha'

describe Ficha do 

  context "nueva ficha" do
    let(:ficha) { FactoryGirl.create(:ficha) }
    subject { ficha }
    it { is_expected.to respond_to(:nombre, :equipos, :mantenimientos) }
  end

  context "nueva ficha con nombre 'Ala'" do
    let(:ficha) { FactoryGirl.create(:ficha, nombre: "Ala") }
    subject { ficha }
    it "is expected to have name 'Ala'" do 
      expect(ficha.nombre).to match('Ala')
    end
  end

  context "10 fichas" do

    it "should create 10 fichas" do 
      (1..10).each { |i| FactoryGirl.create(:ficha)} 
      expect(Ficha.all.length).to be(10)
    end
    
  end
end


describe "ficha con equipos y mantenimientos" do 
  let(:ficha) { FactoryGirl.create(:ficha_with_equipos_and_mantenimientos) }
  subject {ficha}
end

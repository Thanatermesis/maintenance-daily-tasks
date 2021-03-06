require_relative '../spec_helper'

require 'ficha'
require 'mantenimiento'

describe Mantenimiento do 

  context "new" do 
    let(:mantenimiento) { FactoryGirl.create(:mantenimiento) }
    let(:mantenimiento2) { 
      FactoryGirl.create(:mantenimiento, periodicidad: "semestral") 
    }
    subject { mantenimiento }
    it { is_expected.to respond_to(:ficha, :accions, :periodicidad, :waiting_time) }
    it "is expect to have periodicidad mensual" do 
      expect(subject.periodicidad).to eq("mensual")
      expect(mantenimiento2.periodicidad).to eq("semestral")
    end
    it "is expect to wait 6 months for next accion" do 
      expect(mantenimiento.waiting_time).to eq(1.month)
    end
  end

end

describe 'ficha con 10 mantenimientos' do 

  let(:ficha) {FactoryGirl.create(:ficha_with_mantenimientos, mantenimientos_count:10)}
  subject {ficha}
  it "should have 10 mantenimiento" do 
    expect(ficha.mantenimientos.length).to be(10)
  end

end

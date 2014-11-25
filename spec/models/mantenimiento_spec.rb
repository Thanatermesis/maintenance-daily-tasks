require_relative '../spec_helper'

require 'ficha'
require 'mantenimiento'

describe Mantenimiento do 

  context "new" do 
    let(:mantenimiento) { FactoryGirl.create(:mantenimiento) }
    subject { mantenimiento }
    it { is_expected.to respond_to(:ficha, :accions) }
  end

end

describe 'ficha con 10 mantenimientos' do 
  let(:ficha) {FactoryGirl.create(:ficha_with_mantenimientos, mantenimientos_count:10)}
  subject {ficha}
  it "should have 10 mantenimiento" do 
    expect(ficha.mantenimientos.length).to be(10)
  end
end

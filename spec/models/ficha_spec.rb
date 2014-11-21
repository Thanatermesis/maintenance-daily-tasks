require_relative '../spec_helper'

require 'ficha'

describe 'Ficha.new' do 
  subject { Ficha.new }
  it { is_expected.to respond_to(:nombre) }
end


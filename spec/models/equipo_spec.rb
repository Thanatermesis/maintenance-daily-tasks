require_relative '../spec_helper'

require 'ficha'
require 'equipo'

describe 'Equipo.new' do 
  subject { Equipo.new }
  it { is_expected.to respond_to(:ficha, :accions) }
end

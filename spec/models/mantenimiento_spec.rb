require_relative '../spec_helper'

require 'ficha'
require 'mantenimiento'

describe 'Mantenimiento.new' do 
  subject { Mantenimiento.new }
  it { is_expected.to respond_to(:ficha, :accions) }
end

require_relative '../spec_helper'

require 'ficha'
require 'accion'

describe 'Accion.new' do 
  subject { Accion.new }
  it { is_expected.to respond_to(:equipo, :mantenimiento) }
end

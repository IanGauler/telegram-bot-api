require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/cancion'

describe Cancion do
  it 'deberia crear una cancion' do
    cancion = described_class.new('Waka-Waka', 'Shakira', 2010, '3:31')
    expect(cancion).to be_a(described_class)
  end
end

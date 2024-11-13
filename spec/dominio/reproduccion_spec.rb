require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/reproduccion'

describe Reproduccion do
  it 'deberia crear una reproduccion' do
    reproduccion = described_class.new(1, 1)
    expect(reproduccion).to be_a(described_class)
  end
end

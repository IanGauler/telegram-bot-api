require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/megusta'

describe MeGusta do
  it 'deberia crear un megusta' do
    reproduccion = described_class.new(1, 1)
    expect(reproduccion).to be_a(described_class)
  end
end

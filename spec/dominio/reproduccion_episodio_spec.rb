require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/reproduccion_episodio'

describe ReproduccionEpisodio do
  it 'deberia crear una reproduccion de un episodio' do
    reproduccion_episodio = described_class.new('email', 1, 1)
    expect(reproduccion_episodio).to be_a(described_class)
  end
end

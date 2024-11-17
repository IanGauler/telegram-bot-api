require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/episodio'

describe Episodio do
  it 'deberia crear un episodio' do
    episodio = described_class.new(1, 'Caja Negra - Ep1', 'Filo.news', '45:20')
    expect(episodio).to be_a(described_class)
  end
end

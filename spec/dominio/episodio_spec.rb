require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/episodio'

describe Episodio do
  it 'deberia crear un episodio' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    episodio = described_class.new(podcast, 'Caja Negra - Ep1', 'Filo.news', '45:20')
    expect(episodio).to be_a(described_class)
  end
end

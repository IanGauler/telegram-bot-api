require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/podcast'

describe Podcast do
  it 'deberia crear un podcast' do
    podcast = described_class.new('Caja Negra', 'Filo.news', 2020, 1)
    expect(podcast).to be_a(described_class)
  end

  it 'deberia agregarle episodios a un podcast' do
    podcast = described_class.new('Caja Negra', 'Filo.news', 2020, 1)
    podcast.agregar_episodio(Episodio.new(podcast.id, 'Caja Negra - Ep1', 'Filo.news', '45:20'))
    expect(podcast.episodios.size).to be 1
  end
end

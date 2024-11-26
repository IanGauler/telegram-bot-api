require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/episodio'

describe Episodio do
  it 'deberia crear un episodio' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    episodio = described_class.new(podcast, 'Caja Negra - Ep1', 'Filo.news', '45:20')
    expect(episodio).to be_a(described_class)
  end

  it 'deberia representarse como hash' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    episodio = described_class.new(podcast, 'Caja Negra - Ep1', 'Filo.news', '45:20', 1)
    expect(episodio.representacion_hash).to eq({ id: 1, titulo: 'Caja Negra - Ep1', participantes: 'Filo.news', duracion: '45:20' })
  end

  it 'deberia lanzar error TituloVacioEpisodios si el titulo es vacio' do
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
    expect { described_class.new(podcast, '', 'Filo.news', '45:20') }.to raise_error(TituloVacioEpisodios)
  end
end

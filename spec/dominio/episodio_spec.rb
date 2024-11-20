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

  describe 'pertenece_a_podcast' do
    it 'deberia lanzar un error si el episodio no pertenece al podcast' do
      podcast = Podcast.new('Caja Negra', 'Filo.news', 2021)
      episodio = described_class.new(podcast, 'Caja Negra - Ep1', 'Filo.news', '45:20', 1)
      expect { episodio.pertenece_a_podcast(2) }.to raise_error(EpisodioNoPerteneceAPodcast)
    end
  end
end

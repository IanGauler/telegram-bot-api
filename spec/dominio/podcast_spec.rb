require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/podcast'

describe Podcast do
  episodio = Episodio.new('Caja Negra - Ep1', 'Filo.news', '45:20', 2)
  it 'deberia crear un podcast' do
    podcast = described_class.new('Caja Negra', 'Filo.news', 2020, episodio)
    expect(podcast).to be_a(described_class)
  end

  it 'deberia agregarle episodios a un podcast' do
    podcast = described_class.new('Caja Negra', 'Filo.news', 2020, episodio)
    podcast.agregar_episodios(Episodio.new('Caja Negra - Ep1', 'Filo.news', '45:20'))
    expect(podcast.episodios.size).to be 2
  end

  it 'deberia representarse como hash si tiene episodios' do
    podcast = described_class.new('Caja Negra', 'Filo.news', 2020, episodio, 1)
    expect(podcast.representacion_hash).to eq({ titulo: 'Caja Negra', creador: 'Filo.news', anio: 2020, id: 1,
                                                episodios: [{ titulo: 'Caja Negra - Ep1', participantes: 'Filo.news', duracion: '45:20', id: 2 }] })
  end
end

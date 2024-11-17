require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/tipo_contenido'

describe TipoContenido do
  let(:contenido_cancion) { described_class.para(TipoContenido::CANCION) }
  let(:contenido_podcast) { described_class.para(TipoContenido::PODCAST) }
  let(:contenido_episodio) { described_class.para(TipoContenido::EPISODIO) }

  it 'deberia poder crearse para una cancion' do
    expect(contenido_cancion.tipo).to eq(TipoContenido::CANCION)
  end

  it 'deberia poder crearse para un podcast' do
    expect(contenido_podcast.tipo).to eq(TipoContenido::PODCAST)
  end

  it 'deberia poder crearse para un episodio' do
    expect(contenido_episodio.tipo).to eq(TipoContenido::EPISODIO)
  end
end

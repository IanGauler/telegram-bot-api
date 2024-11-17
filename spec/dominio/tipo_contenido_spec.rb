require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/tipo_contenido'

describe TipoContenido do
  let(:contenido) { described_class.para(TipoContenido::CANCION) }

  it 'should have a tipo' do
    expect(contenido.tipo).to eq(TipoContenido::CANCION)
  end
end

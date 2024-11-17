require 'integration_helper'
require_relative '../../dominio/tipo_contenido'
require_relative '../../persistencia/repositorio_contenido'

describe RepositorioContenido do
  respositorio_contenido = described_class.new

  it 'deberia guardar una cancion nueva' do
    contenido = TipoContenido.cancion
    respositorio_contenido.save(contenido)
    contenidos = respositorio_contenido.all
    expect(contenidos.size).to be 1
    expect(contenido.id).not_to be nil
    expect(contenidos.first.tipo).to eq(TipoContenido::CANCION)
  end
end

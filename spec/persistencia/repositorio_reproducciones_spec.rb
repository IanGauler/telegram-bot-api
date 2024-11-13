require 'integration_helper'
require_relative '../../dominio/cancion'
require_relative '../../persistencia/repositorio_reproducciones'

describe RepositorioReproducciones do
  repositorio_reproducciones = described_class.new

  xit 'deberia guardar una cancion nueva' do
    _reproduccion = Reproduccion.new(1, 1)

    repositorio_reproducciones.save(cancion)
    canciones = repositorio_reproducciones.all
    expect(canciones.size).to be 1
  end
end

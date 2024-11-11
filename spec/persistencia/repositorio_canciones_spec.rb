require 'integration_helper'
require_relative '../../dominio/cancion'
require_relative '../../persistencia/repositorio_canciones'

describe RepositorioCanciones do
  respositorio_canciones = described_class.new

  it 'deberia guardar una cancion nueva' do
    artistas = ['Shakira']
    cancion = Cancion.new('Waka-Waka', artistas, 2010, '3:31')
    respositorio_canciones.save(cancion)
    canciones = respositorio_canciones.all
    expect(canciones.size).to be 1
  end
end

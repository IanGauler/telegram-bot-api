require 'integration_helper'
require_relative '../../dominio/reproduccion'
require_relative '../../persistencia/repositorio_reproducciones'
require_relative '../../persistencia/repositorio_canciones'
require_relative '../../persistencia/repositorio_usuarios'

describe RepositorioReproducciones do
  repositorio_reproducciones = described_class.new

  xit 'deberia guardar una reproduccion nueva' do
    cancion = Cancion.new('Cancion1', 'Artista1', 2020, '3:31')
    usuario = Usuario.new(1, 'juan@gmail.com')
    cancion = RepositorioCanciones.new.save(cancion)
    RepositorioUsuarios.new.save(usuario)

    reproduccion = Reproduccion.new(usuario.id, cancion.id)

    repositorio_reproducciones.save(reproduccion)
    reproducciones = repositorio_reproducciones.all
    expect(reproducciones.size).to be 1
  end
end

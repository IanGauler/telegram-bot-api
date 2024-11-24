require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../dominio/megusta'
require_relative '../../persistencia/repositorio_usuarios'
require_relative '../../persistencia/repositorio_canciones'

describe RepositorioMeGustas do
  usuario = Usuario.new('1', 'test@test.com')
  respositorio_megustas = described_class.new

  it 'deberia guardar un me gusta de una cancion' do
    RepositorioUsuarios.new.save(usuario)
    cancion = Cancion.new('titulo', 'autor', 2020, '2:00')
    cancion = RepositorioCanciones.new.save(cancion)
    RepositorioReproducciones.new.save(Reproduccion.new(usuario, cancion))

    respositorio_megustas.save(MeGusta.new(usuario, cancion))
    megustas = respositorio_megustas.all
    expect(megustas.size).to eq 1
    expect(megustas.first.id).not_to be nil
  end
end

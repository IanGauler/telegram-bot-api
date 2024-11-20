require 'integration_helper'
require_relative '../../dominio/reproduccion'
require_relative '../../persistencia/repositorio_reproducciones'
require_relative '../../persistencia/repositorio_canciones'
require_relative '../../persistencia/repositorio_usuarios'

describe RepositorioReproducciones do
  repositorio_reproducciones = described_class.new

  it 'deberia guardar una reproduccion nueva' do
    cancion = Cancion.new('Cancion1', 'Artista1', 2020, '3:31')
    usuario = Usuario.new('1', 'juan@gmail.com')
    cancion = RepositorioCanciones.new.save(cancion)
    RepositorioUsuarios.new.save(usuario)

    reproduccion = Reproduccion.new(usuario, cancion)

    repositorio_reproducciones.save(reproduccion)
    reproducciones = repositorio_reproducciones.all
    expect(reproducciones.size).to be 1
  end

  it 'deberia guardar la reproduccion de un episodio' do
    podcast = Podcast.new('Podcast1', 'Creador1', 2020)
    podcast = RepositorioPodcasts.new.save(podcast)
    episodio = Episodio.new(podcast, 'Episodio1', 'Participante1', '3:31')
    usuario = Usuario.new('1', 'juan@gmail.com')
    episodio = RepositorioEpisodios.new.save(episodio)
    RepositorioUsuarios.new.save(usuario)

    reproduccion = Reproduccion.new(usuario, episodio)

    repositorio_reproducciones.save(reproduccion)
    reproducciones = repositorio_reproducciones.all
    expect(reproducciones.size).to be 1
  end
end

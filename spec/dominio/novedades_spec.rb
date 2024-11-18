require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/novedades'
require_relative '../../persistencia/repositorio_canciones'
require_relative '../../persistencia/repositorio_podcasts'
require_relative '../../persistencia/repositorio_contenido'

describe Novedades do
  it 'deberia obtener los ultimos contenidos añadidos' do
    cancion = crear_cancion
    podcast = crear_podcast
    novedades = described_class.new(5)
    lista_de_novedades = novedades.listar(RepositorioContenido.new)

    cancion_obtenida = lista_de_novedades[0]
    podcast_obtenido = lista_de_novedades[1]
    expect(cancion_obtenida.id).to eq(cancion.id)
    expect(podcast_obtenido.id).to eq(podcast.id)
  end

  it 'deberia no incluir episodios' do
    podcast = crear_podcast
    RepositorioEpisodios.new.save(Episodio.new(podcast, 'Episodio 1', 'Participante 1', '1:00'))

    novedades = described_class.new(5)
    lista_de_novedades = novedades.listar(RepositorioContenido.new)

    expect(lista_de_novedades.size).to eq(1)
  end

  def crear_cancion
    cancion = Cancion.new('Waka-Waka', 'Shakira', 2010, '3:31')
    RepositorioCanciones.new.save(cancion)
  end

  def crear_podcast
    podcast = Podcast.new('Podcast', 'Creador', 2021)
    RepositorioPodcasts.new.save(podcast)
  end
end

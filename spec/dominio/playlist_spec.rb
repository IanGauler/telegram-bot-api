require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/playlist'

describe Playlist do
  playlist = described_class.new
  episodio = Episodio.new('titulo', 'creador', '45:20', 1)
  it 'deberia lanzar ContenidoNoEncontrado si se intenta agregar contenido inexistente a una playlist' do
    expect { playlist.agregar_contenido(nil) }.to raise_error(ContenidoNoEncontrado)
  end

  it 'deberia lanzar AgregarPodcastAPlaylist si se intenta agregar un podcast una su playlist' do
    podcast = Podcast.new('titulo', 'creador', 2021, episodio)

    expect { playlist.agregar_contenido(podcast) }.to raise_error(AgregarPodcastAPlaylist)
  end

  it 'deberia lanzar ContenidoDuplicadoPlaylist si se intenta agregar dos veces un contenido a su playlist' do
    contenido = Cancion.new('titulo', 'artistas', 2021, '2:20', 1)
    playlist.agregar_contenido(contenido)
    expect { playlist.agregar_contenido(contenido) }.to raise_error(ContenidoDuplicadoPlaylist)
  end
end

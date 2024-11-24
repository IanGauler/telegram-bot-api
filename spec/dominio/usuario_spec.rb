require 'integration_helper'
require 'spec_helper'
require_relative '../../dominio/usuario'

describe Usuario do
  usuario = described_class.new(1, 'juan@gmail.com')

  it 'deberia crear un usuario' do
    expect(usuario).to be_a(described_class)
  end

  it 'deberia lanzar ContenidoNoEncontrado si intenta reproducir contenido inexistente' do
    expect { usuario.reproducir(nil) }.to raise_error(ContenidoNoEncontrado)
  end

  it 'deberia poder reproducir contenido' do
    contenido = Cancion.new('titulo', 'artistas', 2021, 180)
    usuario.reproducir(contenido)
    expect(usuario.reproducciones).not_to be_empty
  end

  it 'deberia lanzar ContenidoNoEncontrado si intenta dar me gusta a contenido inexistente' do
    expect { usuario.dar_megusta_a(nil) }.to raise_error(ContenidoNoEncontrado)
  end

  it 'deberia poder dar me gusta a contenido reproducido' do
    contenido = Cancion.new('titulo', 'artistas', 2021, 180)
    usuario.reproducir(contenido)
    usuario.dar_megusta_a(contenido)
    expect(usuario.me_gustas).not_to be_empty
  end

  it 'deberia lanzar ContenidoNoEscuchado si intenta dar me gusta a contenido no escuchado' do
    usuario2 = described_class.new(2, 'juan2@gmail.com')
    contenido = Cancion.new('titulo', 'artistas', 2021, 180)
    expect { usuario2.dar_megusta_a(contenido) }.to raise_error(ContenidoNoEscuchado)
  end

  it 'deberia lanzar ContenidoNoEncontrado si se intenta agregar contenido inexistente a su playlist' do
    expect { usuario.agregar_contenido_a_playlist(nil) }.to raise_error(ContenidoNoEncontrado)
  end

  it 'deberia lanzar AgregarPodcastAPlaylist si se intenta agregar un podcast a su playlist' do
    podcast = Podcast.new('titulo', 'creador', 2021)
    expect { usuario.agregar_contenido_a_playlist(podcast) }.to raise_error(AgregarPodcastAPlaylist)
  end
end

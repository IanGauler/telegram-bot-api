require 'integration_helper'
require_relative '../../dominio/tipo_contenido'
require_relative '../../persistencia/repositorio_contenido'

describe RepositorioContenido do
  respositorio_contenido = described_class.new
  episodio = Episodio.new('titulo', 'participante', '2:00')

  it 'deberia guardar una cancion nueva' do
    RepositorioCanciones.new.save(Cancion.new('titulo', 'autor', 2020, '2:00'))

    contenidos = respositorio_contenido.all
    contenido = contenidos.first

    expect(contenidos.size).to be 1
    expect(contenido.id).not_to be nil
    expect(contenido).to be_a Cancion
  end

  it 'deberia guardar un podcast con su episodio' do
    RepositorioPodcasts.new.save(Podcast.new('titulo', 'autor', 2020, episodio))

    contenidos = respositorio_contenido.all
    podcast = contenidos.first
    episodio = contenidos.last

    expect(contenidos.size).to be 2
    expect(podcast).to be_a Podcast
    expect(episodio).to be_a Episodio
  end
end

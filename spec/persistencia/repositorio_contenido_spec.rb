require 'integration_helper'
require_relative '../../dominio/tipo_contenido'
require_relative '../../persistencia/repositorio_contenido'

describe RepositorioContenido do
  respositorio_contenido = described_class.new

  it 'deberia guardar una cancion nueva' do
    RepositorioCanciones.new.save(Cancion.new('titulo', 'autor', 2020, '2:00'))

    contenidos = respositorio_contenido.all
    contenido = contenidos.first

    expect(contenidos.size).to be 1
    expect(contenido.id).not_to be nil
    expect(contenido).to be_a Cancion
  end

  it 'deberia guardar un podcast' do
    RepositorioPodcasts.new.save(Podcast.new('titulo', 'autor', 2020))

    contenidos = respositorio_contenido.all
    contenido = contenidos.first

    expect(contenidos.size).to be 1
    expect(contenido.id).not_to be nil
    expect(contenido).to be_a Podcast
  end
end

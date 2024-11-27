require 'integration_helper'
require_relative '../../dominio/podcast'
require_relative '../../persistencia/repositorio_podcasts'
require_relative '../../persistencia/repositorio_contenido'
require_relative '../../dominio/tipo_contenido'

describe RepositorioPodcasts do
  respositorio_podcasts = described_class.new
  repositorio_contenido = RepositorioContenido.new
  episodio = Episodio.new('Ep1', 'Filo.news', '2:00')

  def crear_podcast_con_episodios(respositorio_podcasts)
    episodio = Episodio.new('Ep1', 'Filo.news', '2:00')
    podcast = Podcast.new('Caja Negra', 'Filo.news', 2020, episodio)
    respositorio_podcasts.save(podcast)
    podcast
  end

  it 'deberia guardar un podcast' do
    episodio = Episodio.new('Ep1', 'Filo.news', '2:00')
    podcast = Podcast.new('Podcast1', 'Autor1', 2020, episodio)
    respositorio_podcasts.save(podcast)
    podcasts = respositorio_podcasts.all

    expect(podcasts.size).to be 1
    expect(podcasts.first.id).not_to be nil
  end

  it 'deberia guardar un podcast con episodios' do
    podcast = crear_podcast_con_episodios(respositorio_podcasts)
    contenidos = repositorio_contenido.all
    contenido = contenidos.first
    expect(contenido).to be_a Podcast
    expect(contenido.episodios.first.podcast.id).to eq(podcast.id)
  end
end

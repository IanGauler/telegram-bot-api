require 'integration_helper'
require_relative '../../dominio/podcast'
require_relative '../../persistencia/repositorio_contenido'
require_relative '../../persistencia/repositorio_podcasts'
require_relative '../../persistencia/repositorio_episodios'
require_relative '../../dominio/tipo_contenido'

describe RepositorioEpisodios do
  respositorio_episodios = described_class.new

  it 'deberia guardar un episodio' do
    episodio = Episodio.new('Episodio1', 'Participante1', '59:00')
    podcast = Podcast.new('Podcast1', 'Autor1', 2020, episodio)
    podcast_con_id = RepositorioPodcasts.new.save(podcast)

    respositorio_episodios.save(podcast_con_id.episodios.first)

    episodios = respositorio_episodios.all
    expect(episodios.size).to be 1
    expect(episodios.first.id).not_to be nil
  end

  it 'deberia obtener episodios por podcast' do
    episodio = Episodio.new('Episodio1', 'Participante1', '59:00')
    podcast = RepositorioPodcasts.new.save(Podcast.new('Podcast1', 'Autor1', 2020, episodio))

    episodios = respositorio_episodios.obtener_episodios_por_id_podcast(podcast.id)
    expect(episodios.size).to be 1
    expect(episodios.first.id).not_to be nil
  end
end

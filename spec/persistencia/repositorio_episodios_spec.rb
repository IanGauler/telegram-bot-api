require 'integration_helper'
require_relative '../../dominio/podcast'
require_relative '../../persistencia/repositorio_contenido'
require_relative '../../persistencia/repositorio_podcasts'
require_relative '../../persistencia/repositorio_episodios'
require_relative '../../dominio/tipo_contenido'

describe RepositorioEpisodios do
  respositorio_episodios = described_class.new

  it 'deberia guardar un episodio' do
    podcast = Podcast.new('Podcast1', 'Autor1', 2020)
    RepositorioPodcasts.new.save(podcast)

    episodio = Episodio.new(podcast.id, 'Episodio1', 'Participante1', '59:00')
    respositorio_episodios.save(episodio)

    episodios = respositorio_episodios.all
    expect(episodios.size).to be 1
    expect(episodios.first.id).not_to be nil
  end
end

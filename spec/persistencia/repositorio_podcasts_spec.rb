require 'integration_helper'
require_relative '../../dominio/podcast'
require_relative '../../persistencia/repositorio_podcasts'
require_relative '../../persistencia/repositorio_contenido'
require_relative '../../dominio/tipo_contenido'

describe RepositorioPodcasts do
  respositorio_podcasts = described_class.new

  it 'deberia guardar un podcast' do
    podcast = Podcast.new('Podcast1', 'Autor1', 2020)
    respositorio_podcasts.save(podcast)
    podcasts = respositorio_podcasts.all

    expect(podcasts.size).to be 1
    expect(podcasts.first.id).not_to be nil
  end
end

require 'spec_helper'
require 'integration_helper'
require 'dotenv/load'
require_relative '../../conectores/conector_spotify'

describe ConectorSpotify do
  conector = described_class.new

  describe 'artistas similares' do
    it 'deberia buscar un artista' do
      artista = 'Beyonce'

      recomendados = conector.artistas_similares(artista, 5)

      expect(recomendados.size).to eq 5
    end
  end
end

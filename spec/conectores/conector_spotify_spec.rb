require 'spec_helper'
require 'integration_helper'
require 'dotenv/load'
require_relative '../../conectores/conector_spotify'

describe ConectorSpotify do
  conector = described_class.new(ENV['SPOTIFY_API_URL'], ENV['SPOTIFY_ACCOUNT_API_URL'], Configuration.logger)

  describe 'artistas similares' do
    it 'deberia buscar un artista' do
      artista = 'Beyonce'

      recomendados = conector.artistas_similares(artista, 5)

      expect(recomendados.size).to eq 5
    end

    it 'deberia regenerar token invaildo' do
      artista = 'Beyonce'
      conector.instance_variable_set(:@api_token, 'token invalido')

      recomendados = conector.artistas_similares(artista, 5)

      expect(recomendados.size).to eq 5
    end
  end
end

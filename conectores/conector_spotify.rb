require_relative '../config/configuration'
require 'faraday'

class ConectorSpotify
  def initialize(api_url = ENV['SPOTIFY_API_URL'], client_id = ENV['SPOTIFY_CLIENT_ID'], client_secret = ENV['SPOTIFY_CLIENT_SECRET'])
    @api_url = api_url
    @client_id = client_id
    @client_secret = client_secret
    @api_url = api_url
    @api_token = nil
  end

  def artistas_similares(artista, cantidad)
    # TODO: Reintentar cuando el token se vence
    regenrar_api_token if @api_token.nil?

    id_artista = buscar_artista(artista)

    uri = "#{@api_url}/artists/#{id_artista}/related-artists"
    headers = {
      'Authorization' => "Bearer #{@api_token}"
    }

    response = Faraday.get(uri, nil, headers)

    JSON.parse(response.body)['artists'].map { |artista_recomendado| artista_recomendado['name'] }.take(cantidad)
  end

  private

  def buscar_artista(artista)
    uri = "#{@api_url}/search?q=#{artista}&type=artist"
    headers = {
      'Authorization' => "Bearer #{@api_token}"
    }

    response = Faraday.get(uri, nil, headers)

    JSON.parse(response.body)['artists']['items'].first['id']
  end

  def query_api_token
    uri = 'https://accounts.spotify.com/api/token'
    body = {
      'grant_type' => 'client_credentials',
      'client_id' => @client_id,
      'client_secret' => @client_secret
    }
    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }

    Faraday.post(uri, body, headers)
  end

  def regenrar_api_token
    # TODO: manejo de errores
    response = query_api_token

    @api_token = JSON.parse(response.body)['access_token']
  end
end

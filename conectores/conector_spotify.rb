require_relative '../config/configuration'
require 'faraday'

class ConectorSpotify
  N_REINTENTOS = 3

  def initialize(api_url, auth_url, client_id = ENV['SPOTIFY_CLIENT_ID'], client_secret = ENV['SPOTIFY_CLIENT_SECRET'])
    @api_url = api_url
    @client_id = client_id
    @client_secret = client_secret
    @api_url = api_url
    @auth_url = auth_url
    @api_token = nil
  end

  def artistas_similares(artista, cantidad)
    # TODO: Reintentar cuando el token se vence
    regenrar_api_token if @api_token.nil?

    id_artista = buscar_artista(artista)

    similares = obtener_similares(id_artista)

    similares['artists'].map { |artista_recomendado| artista_recomendado['name'] }.take(cantidad)
  end

  private

  def obtener_similares(id_artista, reintentos = N_REINTENTOS)
    uri = "#{@api_url}/artists/#{id_artista}/related-artists"
    headers = {
      'Authorization' => "Bearer #{@api_token}"
    }

    response = Faraday.get(uri, nil, headers)
    if response.status == 401 && reintentos > 0
      regenrar_api_token
      return obtener_similares(artista, cantidad, reintentos - 1)
    end
    raise ErrorSpotify, 'Error al buscar artistas similares en Spotify' unless response.status == 200

    JSON.parse(response.body)
  end

  def buscar_artista(artista, reintentos = 3)
    uri = "#{@api_url}/search?q=#{artista}&type=artist"
    headers = {
      'Authorization' => "Bearer #{@api_token}"
    }

    response = Faraday.get(uri, nil, headers)
    if response.status == 401 && reintentos > 0
      regenrar_api_token
      return buscar_artista(artista, reintentos - 1)
    end
    raise ErrorSpotify, 'Error al buscar artista en Spotify' unless response.status == 200

    JSON.parse(response.body)['artists']['items'].first['id']
  end

  def query_api_token
    uri = "#{@auth_url}/token"
    body = {
      'grant_type' => 'client_credentials',
      'client_id' => @client_id,
      'client_secret' => @client_secret
    }
    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }

    response = Faraday.post(uri, body, headers)
    raise ErrorSpotify, 'Error al obtener token de Spotify' unless response.status == 200

    response
  end

  def regenrar_api_token
    # TODO: manejo de errores
    response = query_api_token

    @api_token = JSON.parse(response.body)['access_token']
  end
end

class ErrorConectorRecomendaciones < StandardError
end

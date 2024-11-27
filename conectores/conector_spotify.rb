require_relative '../config/configuration'
require 'faraday'

class ConectorSpotify
  N_REINTENTOS = 3
  AUTH_URL = ENV['SPOTIFY_ACCOUNT_API_URL']

  def initialize(api_url, logger, client_id = ENV['SPOTIFY_CLIENT_ID'], client_secret = ENV['SPOTIFY_CLIENT_SECRET'], recommendation_url = ENV['SPOTIFY_RECOMENDATION_URL'])
    @api_url = api_url
    @client_id = client_id
    @client_secret = client_secret
    @auth_url = AUTH_URL
    @logger = logger
    @recommendation_url = recommendation_url
    @api_token = nil
  end

  def artistas_similares(artista, cantidad)
    regenerar_api_token if @api_token.nil?

    id_artista = buscar_artista(artista)
    similares = obtener_similares(id_artista)

    recomendados = similares['artists'].map { |artista_recomendado| artista_recomendado['name'] }.take(cantidad)
    @logger.info "Artistas similares a #{artista}: #{recomendados.join(', ')}"
    recomendados
  end

  private

  def obtener_similares(id_artista, reintentos = N_REINTENTOS)
    uri = if @recommendation_url.nil?
            "#{@api_url}/artists/#{id_artista}/related-artists"
          else
            @recommendation_url.to_s
          end

    headers = {
      'Authorization' => "Bearer #{@api_token}"
    }

    @logger.info "Obteniendo artistas similares de #{id_artista} en #{uri}"
    response = Faraday.get(uri, nil, headers)

    if response.status == 401 && reintentos > 0
      regenerar_api_token
      return obtener_similares(artista, cantidad, reintentos - 1)
    end
    assert_respuesta_ok(response, 'Error al obtener artistas similares en Spotify')

    JSON.parse(response.body)
  end

  def buscar_artista(artista, reintentos = 3)
    uri = "#{@api_url}/search?q=#{artista}&type=artist"
    headers = {
      'Authorization' => "Bearer #{@api_token}"
    }

    @logger.info "Buscando artista #{artista} en #{uri}"
    response = Faraday.get(uri, nil, headers)

    if response.status == 401 && reintentos > 0
      regenerar_api_token
      return buscar_artista(artista, reintentos - 1)
    end
    assert_respuesta_ok(response, 'Error al buscar artista en Spotify')

    primero = JSON.parse(response.body)['artists']['items'].first
    @logger.info "Artista encontrado: #{primero['name']} (#{primero['id']})"
    primero['id']
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
    unless response.status == 200
      @logger.error "Error al obtener token de Spotify: #{response.body}"
      raise ErrorConectorRecomendaciones, 'Error al obtener token de Spotify'
    end
    @logger.info 'Token de Spotify (re-)generado correctamente'

    response
  end

  def regenerar_api_token
    @logger.info 'Token expirado, regenerando...'
    response = query_api_token

    @api_token = JSON.parse(response.body)['access_token']
  end

  def assert_respuesta_ok(response, mensaje_error)
    unless response.status == 200
      @logger.error "#{mensaje_error}: #{response.body}"
      raise ErrorConectorRecomendaciones, mensaje_error
    end
  end
end

class ErrorConectorRecomendaciones < StandardError
end

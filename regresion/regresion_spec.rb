require 'faraday'
require_relative '../dominio/cancion'
require 'dotenv/load'
require_relative './regression_helper'

describe 'Test de Regresion', regression: true do
  api_url = ENV['API_URL'] || 'https://algoserompio.com'
  timestamp = Time.now.strftime('%Y%m%d%H%M%S')
  email = "#{timestamp}@test.com"

  Faraday.new(url: api_url) do |faraday|
    faraday.request :url_encoded
    faraday.adapter Faraday.default_adapter
  end

  it 'deberia crear un usuario' do
    endpoint = "#{api_url}/usuarios"
    registro_usuario = { email:, id: timestamp.to_s }

    response = Faraday.post(endpoint, registro_usuario.to_json, { 'Content-Type' => 'application/json' })
    usuario = JSON.parse(response.body)

    expect(response.status).to eq(201)
    expect(usuario['email']).to eq(registro_usuario[:email])
    expect(usuario['id']).to eq(registro_usuario[:id])
  end

  it 'deberia crear una cancion' do
    cancion = [{ titulo: "titulo#{timestamp}#{timestamp}", duracion: '1:59', artistas: "Artistas#{timestamp}", anio: 2024 }]
    response = Faraday.post("#{api_url}/canciones", cancion.to_json, { 'Content-Type' => 'application/json' })
    expect(response.status).to eq(201)
    response = Faraday.get("#{api_url}/canciones")

    canciones = JSON.parse(response.body)
    cancion_devuelta = canciones.find { |c| c['titulo'] == cancion[0][:titulo] }
    comparar_respuesta(cancion, cancion_devuelta)
    expect(cancion_devuelta['id']).not_to be_nil
  end

  it 'deberia crear un podcast' do
    episodio = [{ titulo: "titulo2#{timestamp}#{timestamp}", duracion: '1:20', participantes: "Participantes#{timestamp}" }]
    podcast = [{ titulo: "titulo3#{timestamp}#{timestamp}", creador: "creador#{timestamp}", anio: 2024, episodios: episodio }]

    Faraday.post("#{api_url}/podcasts", podcast.to_json, { 'Content-Type' => 'application/json' })
    response = Faraday.get("#{api_url}/podcasts")

    podcasts = JSON.parse(response.body)

    podcast_devuelto = podcasts.find { |p| p['titulo'] == podcast[0][:titulo] }
    comparar_respuesta(podcast, podcast_devuelto)
    expect(podcast_devuelto['episodios'].first['titulo']).to eq(episodio[0][:titulo])
  end

  it 'deberia poder reproducir una cancion' do
    usuario = crear_usuario(timestamp, api_url)
    cancion = crear_cancion(timestamp, api_url)
    body_enviado = { email: }.to_json

    respuesta = Faraday.post("#{api_url}/canciones/#{cancion['id']}/reproduccion", body_enviado, { 'Content-Type' => 'application/json' })

    expect(respuesta.status).to eq(201)
    reproducciones = Faraday.get("#{api_url}/reproducciones")

    reproduccion = JSON.parse(reproducciones.body).find { |r| r['id_contenido'] == cancion['id'] && r['id_usuario'] == usuario['id'] }
    expect(reproduccion).not_to be_nil
  end

  def crear_usuario(timestamp, api_url)
    email = "#{timestamp}@test.com"
    endpoint = "#{api_url}/usuarios"
    registro_usuario = { email:, id: timestamp.to_s }

    Faraday.post(endpoint, registro_usuario.to_json, { 'Content-Type' => 'application/json' })
    response = Faraday.get(endpoint, nil)
    usuarios = JSON.parse(response.body)
    usuarios.find { |u| u['email'] == registro_usuario[:email] }
  end

  def crear_cancion(timestamp, api_url)
    cancion = [{ titulo: "titulo#{timestamp}#{timestamp}", duracion: '1:59', artistas: "Artistas#{timestamp}", anio: 2024 }]
    Faraday.post("#{api_url}/canciones", cancion.to_json, { 'Content-Type' => 'application/json' })
    response = Faraday.get("#{api_url}/canciones")

    canciones = JSON.parse(response.body)
    canciones.find { |c| c['titulo'] == cancion[0][:titulo] }
  end

  def comparar_respuesta(contenido, respuesta)
    contenido.each do |atributo, valor|
      expect(respuesta[atributo.to_s]).to eq(valor)
    end
  end
end

def me_gusta_cancion(cancion, usuario)
  id_cancion = cancion[:id]
  endpoint_me_gusta_cancion = "/canciones/#{id_cancion}/megustas"

  response = Faraday.post(endpoint_me_gusta_cancion, { id_cancion:, email: usuario[:email] }.to_json, { 'Content-Type' => 'application/json' })

  expect(response.status).to eq(201)
end

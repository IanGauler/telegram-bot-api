require 'faraday'
require_relative '../dominio/cancion'
require  'dotenv/load'

describe 'Test de Regresion', regression: true do
  api_url = ENV['API_URL'] || 'https://algoserompio.com'
  Faraday.new(url: api_url) do |faraday|
    faraday.request :url_encoded
    faraday.adapter Faraday.default_adapter
  end
  timestamp = Time.now.strftime('%Y%m%d%H%M%S')

  it 'deberia crear un usuario' do
    endpoint = "#{api_url}/usuarios"
    email = "#{timestamp}@test.com"
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

  def comparar_respuesta(contenido, respuesta)
    contenido.each do |atributo, valor|
      expect(respuesta[atributo.to_s]).to eq(valor)
    end
  end
end

# Recomendaciones de artistas: TODO!eproducir_cancion(cancion, usuario)

def pruebas_api(timestamp)
  usuario = crear_usuario(timestamp)
  cancion = crear_cancion(timestamp)
  reproducir_cancion(cancion, usuario)
  me_gusta_cancion(cancion, usuario)
end

# def faraday_connection
#   api_url = ENV['API_URL'] || 'https://algoserompio.com'
#   Faraday.new(url: api_url) do |faraday|
#     faraday.request :url_encoded
#     faraday.adapter Faraday.default_adapter
#   end
# end

def comparar_respuesta(contenido, respuesta)
  contenido.each do |atributo, valor|
    expect(respuesta[atributo]).to eq(valor)
  end
end

def crear_cancion(timestamp)
  cancion = { titulo: "titulo1#{timestamp}#{timestamp}", duracion: 180, artistas: "Artistas#{timestamp}", anio: 2024 }
  response = Faraday.post('/canciones', cancion.to_json, { 'Content-Type' => 'application/json' })

  expect(response.status).to eq(201)
  cancion_devuelta = JSON.parse(response.body)
  comparar_respuesta(cancion, cancion_devuelta)
  expect(cancion[:id]).not_to be_nil
end

def crear_podcast(timestamp)
  episodio = [{ titulo: "titulo2#{timestamp}#{timestamp}", duracion: '1:80', participantes: "Participantes#{timestamp}" }].to_json
  podcast = { titulo: "titulo3#{timestamp}#{timestamp}", creador: "creador#{timestamp}", anio: 2024, episodios: episodio }

  response = Faraday.post('/podcasts', podcast.to_json, { 'Content-Type' => 'application/json' })

  podcast_devuelto = JSON.parse(response.body)
  comparar_respuesta(podcast, podcast_devuelto)
  expect(podcast_devuelto[:episodios].first[:titulo]).to eq(episodio[:titulo])
end

# # Probamos novedades

# endpoint_novedades = '/novedades'
# @response = Faraday.get(endpoint_novedades)

def reproducir_cancion(cancion, usuario)
  id_cancion = cancion[:id]
  endpoint_reproduccion_cancion = "/canciones/#{id_cancion}/reproduccion"

  response = Faraday.post(endpoint_reproduccion_cancion, { id_cancion:, email: usuario[:email] }.to_json, { 'Content-Type' => 'application/json' })

  expect(response.status).to eq(201)
end

def me_gusta_cancion(cancion, usuario)
  id_cancion = cancion[:id]
  endpoint_me_gusta_cancion = "/canciones/#{id_cancion}/megustas"

  response = Faraday.post(endpoint_me_gusta_cancion, { id_cancion:, email: usuario[:email] }.to_json, { 'Content-Type' => 'application/json' })

  expect(response.status).to eq(201)
end

def main
  timestamp = Time.now.strftime('%Y%m%d%H%M%S')

  faraday_connection
  pruebas_api(timestamp)
end

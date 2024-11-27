require 'faraday'
require_relative '../dominio/cancion'

describe 'Test de Regresion', regression: true do
  it 'deberia crear una cancion' do
    cancion = Cancion.new('Waka-Waka', 'Shakira', 2010, '3:31')
    expect(cancion).to be_a(Cancion)
  end
end

# Recomendaciones de artistas: TODO!eproducir_cancion(cancion, usuario)

def pruebas_api(timestamp)
  usuario = crear_usuario(timestamp)
  cancion = crear_cancion(timestamp)
  reproducir_cancion(cancion, usuario)
  me_gusta_cancion(cancion, usuario)
end

def faraday_connection
  api_url = ENV['API_URL'] || 'https://algoserompio.com'
  Faraday.new(url: api_url) do |faraday|
    faraday.request :url_encoded
    faraday.adapter Faraday.default_adapter
  end
end

def crear_usuario(timestamp)
  endpoint = '/usuarios'
  email = "#{timestamp}@test.com"
  registro_usuario = { email:, id: timestamp.to_s }

  response = Faraday.post(endpoint, request_body, { 'Content-Type' => 'application/json' })

  expect(response.status).to eq(201)
  usuario = JSON.parse(response.body)
  expect(usuario).to eq(registro_usuario)

  usuario
end

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

  podcast_devuellto = JSON.parse(response.body)
  comparar_respuesta(podcast, podcast_devuellto)
  expect(podcast_devuellto[:episodios].first[:titulo]).to eq(episodio[:titulo])
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

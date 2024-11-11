Dado('que quiero cargar la cancion {string} del artista {string} lanzada en el año {string} y con una duracion {string}') do |titulo, artista, anio, duracion|
  RepositorioCanciones.new.delete_all
  puts RepositorioCanciones.new.all
  artistas = [artista]
  @request_body = { titulo:, artistas:, anio:, duracion: }.to_json
end

Cuando('publico en la API con {string} esas canciones') do |endpoint|
  @response = Faraday.post(endpoint, @request_body, { 'Content-Type' => 'application/json' })
end

Entonces('la cancion {string} es dada de alta') do |titulo|
  expect(@response.status).to eq(201)
  response = Faraday.get('/canciones', {}, { 'Content-Type' => 'application/json' })
  response_body = JSON.parse(response.body)
  expect(response_body.size).to eq(1)
  expect(response_body.first['titulo']).to eq(titulo)
  expect(response_body.first['id']).to be > 0
end

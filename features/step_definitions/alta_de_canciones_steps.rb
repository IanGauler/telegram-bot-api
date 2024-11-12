Dado('que no hay canciones en la plataforma') do
  RepositorioCanciones.new.delete_all
  @canciones = []
end

Dado('que quiero cargar la cancion {string} del artista {string} lanzada en el año {string} y con una duracion {string}') do |titulo, artista, anio, duracion|
  artistas = [artista]
  @canciones << ({ titulo:, artistas:, anio:, duracion: })
end

Cuando('publico en la API con {string} esas canciones') do |endpoint|
  canciones = @canciones.to_json
  @response = Faraday.post(endpoint, canciones, { 'Content-Type' => 'application/json' })
end

Entonces('la cancion {string} es dada de alta') do |titulo|
  expect(@response.status).to eq(201)
  response = Faraday.get('/canciones')
  response_body = JSON.parse(response.body)
  cancion = response_body.find { |c| c['titulo'] == titulo }
  expect(cancion['id']).to be > 0
end

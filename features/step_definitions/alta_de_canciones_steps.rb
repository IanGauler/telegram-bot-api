Dado('que quiero cargar la cancion {string} del artista {string} lanzada en el año {string} y con una duracion {string}') do |titulo, artista, anio, duracion|
  artistas = [artista]
  @request_body = { titulo:, artistas:, anio:, duracion: }.to_json
end

Cuando('publico en la API con {string} esas canciones') do |endpoint|
  @response = Faraday.post(endpoint, @request_body, { 'Content-Type' => 'application/json' })
end

Entonces('la cancion {string} es dada de alta') do |titulo|
  expect(@response.status).to eq(201)
  cancion = RepositorioCanciones.new.all.first
  expect(cancion.titulo).to eq(titulo)
end

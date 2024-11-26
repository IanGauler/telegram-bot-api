Dado('que existe una canción de {string} en la plataforma') do |artista|
  repositorio_canciones = RepositorioCanciones.new
  @canciones ||= {}
  cancion = Cancion.new("titulo-#{artista}", artista, 2020, '2:00')
  @canciones[artista] = cancion

  repositorio_canciones.save(cancion)
end

Dado('que tengo acceso a Spotify') do
end

Cuando('busco artistas recomendados') do
  request_body = { id: @usuario.id.to_s }.to_json
  @response = Faraday.get('/recomendaciones/artistas', request_body, { 'Content-Type' => 'application/json' })
end

Dado('que escuché {string} veces a {string}') do |cantidad, artista|
  cancion = @canciones[artista]
  repositorio_reproducciones = RepositorioReproducciones.new
  cantidad.to_i.times do
    repositorio_reproducciones.save(Reproduccion.new(@usuario, cancion))
  end
end

Entonces('me recomiendan {string} de artistas parecidos a {string}') do |cantidad, artista|
  response = @response.body
  recomendaciones = JSON.parse(response)
  expect(recomendaciones['top_escuchado']).to eq(artista)
  expect(recomendaciones['artistas_recomendados'].size).to eq(cantidad.to_i)
end

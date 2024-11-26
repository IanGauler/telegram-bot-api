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

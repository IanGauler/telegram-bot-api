Dado('que existe una canción de {string} en la plataforma') do |artista|
  repositorio_canciones = RepositorioCanciones.new
  @canciones ||= {}
  cancion = Cancion.new("titulo-#{artista}", artista, 2020, '2:00')
  @canciones[artista] = cancion

  repositorio_canciones.save(cancion)
end

Dado('que tengo acceso a Spotify') do
  @spotify_ok = true
end

Dado('que no tengo acceso a Spotify') do
  @spotify_ok = false
  allow_any_instance_of(ConectorSpotify).to receive(:artistas_similares).and_raise(ErrorConectorRecomendaciones)
end

Cuando('busco artistas recomendados') do
  @response = Faraday.get('/recomendaciones/artistas', { id: @usuario.id.to_s }, { 'Content-Type' => 'application/json' })
end

Dado('que escuché {string} veces a {string}') do |cantidad, artista|
  cancion = @canciones[artista]
  repositorio_reproducciones = RepositorioReproducciones.new
  cantidad.to_i.times do
    repositorio_reproducciones.save(Reproduccion.new(@usuario, cancion))
  end
  mock_spotify_para_devolver(artista, 5)
end

Entonces('me recomiendan {string} artistas parecidos a {string}') do |cantidad, artista|
  response = @response.body
  recomendaciones = JSON.parse(response)
  expect(recomendaciones.size).to eq(cantidad.to_i)
  cantidad.to_i.times do |i|
    expect(recomendaciones[i]).to eq("#{artista}-#{i}")
  end
end

def mock_spotify_para_devolver(artista, cantidad)
  artistas = []
  cantidad.times do |i|
    artistas << "#{artista}-#{i}"
  end
  allow_any_instance_of(ConectorSpotify).to receive(:artistas_similares).with(artista, cantidad).and_return(artistas) if @spotify_ok
end

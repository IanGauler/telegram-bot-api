Dado('que he reproducido la cancion {string}') do |_cancion|
  @id_cancion = RepositorioCanciones.new.all.first.id
  @id_usuario = RepositorioUsuarios.new.all.first.id

  usuario = RepositorioUsuarios.new.find(@id_usuario)
  cancion = RepositorioCanciones.new.find(@id_cancion)

  reproduccion = Reproduccion.new(usuario, cancion)
  RepositorioReproducciones.new.save(reproduccion)
end

Cuando('envio el comando {string} con la id de {string}') do |_comando, cancion|
  @id_contenido = RepositorioCanciones.new.all.first.id
  @id_contenido = 0 if cancion == 'Cancion Inexistente'
  request_body = { id_usuario: @id_usuario }.to_json
  @response = Faraday.post("/contenidos/#{@id_contenido}/megusta", request_body, { 'Content-Type' => 'application/json' })
end

Dado('que existe el podcast {string} con el episodio {string}') do |nombre_podcast, nombre_episodio|
  episodio = Episodio.new(nombre_episodio, 'Participantes', '2:00')
  podcast = Podcast.new(nombre_podcast, 'Creador', 2020, episodio)
  RepositorioPodcasts.new.save(podcast)
end

Dado('que he reproducido el episodio {string}') do |_nombre_episodio|
  request_body = { email: @usuario.email }.to_json
  podcast = RepositorioPodcasts.new.all.first
  id_episodio = RepositorioEpisodios.new.all.first.id
  Faraday.post("/podcasts/#{podcast.id}/episodio/#{id_episodio}/reproduccion", request_body, { 'Content-Type' => 'application/json' })
end

Cuando('envio el comando {string} con el id de {string}') do |_comando, nombre_podcast|
  @id_contenido = RepositorioPodcasts.new.all.first.id
  @id_contenido = 0 if nombre_podcast == 'Podcast Inexistente'
  @id_contenido = RepositorioEpisodios.new.all.first.id if nombre_podcast == 'Ep1'
  request_body = { id_usuario: @id_usuario }.to_json
  @response = Faraday.post("/contenidos/#{@id_contenido}/megusta", request_body, { 'Content-Type' => 'application/json' })
end

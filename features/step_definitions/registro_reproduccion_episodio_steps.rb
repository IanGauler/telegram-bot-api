Cuando('el sistema recibe una solicitud de registro con mail {string} del primer episodio de {string}') do |email, _nombre_podcast|
  request_body = { email: }.to_json
  podcast = RepositorioPodcasts.new.all.first
  @contenido = RepositorioEpisodios.new.obtener_episodios_por_podcast(podcast).first
  id_episodio = @contenido.id
  @response = Faraday.post("/podcasts/#{podcast.id}/episodio/#{id_episodio}/reproduccion", request_body, { 'Content-Type' => 'application/json' })
end

Cuando('el sistema recibe una solicitud de registro con mail {string} de un podcast inexistente') do |email|
  request_body = { email: }.to_json
  @response = Faraday.post('/podcasts/0/episodio/0/reproduccion', request_body, { 'Content-Type' => 'application/json' })
end

Cuando('el sistema recibe una solicitud de registro con mail {string} de un episodio inexistente') do |email|
  request_body = { email: }.to_json
  id_podcast = RepositorioPodcasts.new.all.first.id
  @response = Faraday.post("/podcasts/#{id_podcast}/episodio/0/reproduccion", request_body, { 'Content-Type' => 'application/json' })
end

Cuando('el sistema recibe una solicitud de registro con mail {string} del podcast de {string} y id del primer episodio de {string}') do |email, _nombre_podcast, _nombre_podcast_episodio|
  request_body = { email: }.to_json
  podcasts = RepositorioPodcasts.new.all
  caja_negra = podcasts.find { |podcast| podcast.titulo == 'Caja Negra' }
  manuelita = podcasts.find { |podcast| podcast.titulo == 'Manuelita' }
  episodio_manuelita = RepositorioEpisodios.new.obtener_episodios_por_podcast(manuelita).first
  @response = Faraday.post("/podcasts/#{caja_negra.id}/episodio/#{episodio_manuelita.id}/reproduccion", request_body, { 'Content-Type' => 'application/json' })
end

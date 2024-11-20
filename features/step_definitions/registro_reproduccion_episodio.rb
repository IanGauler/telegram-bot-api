Cuando('el sistema recibe una solicitud de registro con mail {string} del primer episodio de {string}') do |email, _nombre_podcast|
  request_body = { email: }.to_json
  id_podcast = RepositorioPodcasts.new.all.first.id
  @contenido = RepositorioEpisodios.new.obtener_episodios_por_podcast(id_podcast).first
  id_episodio = @contenido.id
  @response = Faraday.post("/podcasts/#{id_podcast}/episodio/#{id_episodio}/reproduccion", request_body, { 'Content-Type' => 'application/json' })
end

Cuando('el sistema recibe una solicitud de registro con mail {string} de un podcast inexistente') do |email|
  request_body = { email: }.to_json
  @response = Faraday.post('/podcasts/0/episodio/0/reproduccion', request_body, { 'Content-Type' => 'application/json' })
end

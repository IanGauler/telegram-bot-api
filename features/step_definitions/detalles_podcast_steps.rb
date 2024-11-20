Dado('que existe el podcast {string} con {string} episodios') do |titulo, cantidad_episodios|
  podcast = Podcast.new(titulo, 'Filo.news', 2020)
  RepositorioPodcasts.new.save(podcast)
  @podcast = RepositorioPodcasts.new.all.last
  episodios = []
  cantidad_episodios.to_i.times do |i|
    episodio = Episodio.new(@podcast, "Ep#{i}", 'Participante1', '59:00')
    episodios << episodio
    RepositorioEpisodios.new.save(episodio)
  end
  @podcast.agregar_episodios(episodios)
end

Cuando('consulto los detalles de {string}') do |_titulo|
  @response = Faraday.get("contenidos/#{@podcast.id}")
end

Cuando('consulto los detalles del contenido inexistente') do
  @response = Faraday.get('contenidos/0')
  expect(@response.status).to eq(404)
  expect(@response.body).to eq('{"error":"El contenido no fue encontrado."}')
end

Entonces('el bot muestra los detalles del podcast') do |_detalles_podcast|
  expect(@response.status).to eq(200)

  body = JSON.parse(@response.body)
  expect(body['titulo']).to eq(@podcast.titulo)
  expect(body['creador']).to eq(@podcast.creador)
  expect(body['anio']).to eq(@podcast.anio)

  expect(body['episodios'].size).to eq(2)
end

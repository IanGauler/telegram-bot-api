Dado('que no hay podcasts en la plataforma') do
  @podcasts = []
end

Dado('que quiero cargar el podcast {string} de {string} lanzado en el año {string} con {string} episodios') do |titulo_podcast, creador, anio, cantidad_episodios|
  @podcasts << ({ titulo_podcast:, creador:, anio:, cantidad_episodios: })
end

Cuando('publico en la API con {string}') do |endpoint|
  podcasts = @podcasts.to_json
  @response = Faraday.post(endpoint, podcasts, { 'Content-Type' => 'application/json' })
end

Entonces('el podcast {string} es dado de alta') do |titulo|
  expect(@response.status).to eq(201)

  response = Faraday.get('/podcasts')
  response_body = JSON.parse(response.body)

  podcast = response_body.find { |c| c['titulo'] == titulo }
  expect(podcast['id']).to be > 0
end

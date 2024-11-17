Dado('que no hay podcasts en la plataforma') do
  @podcasts = []
end

Dado('que quiero cargar el podcast {string} de {string} lanzado en el año {string} con {string} episodios') do |titulo, creador, anio, cantidad_episodios|
  episodios = []
  cantidad_episodios.to_i.times do |i|
    episodios << ({ titulo: "Ep#{i}", participantes: creador, duracion: '30:00' })
  end
  @podcasts << ({ titulo:, creador:, anio:, episodios: })
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

  expect(podcast['titulo']).not_to be_nil
  expect(podcast['creador']).not_to be_nil
  expect(podcast['anio']).not_to be_nil
  expect(podcast['id']).not_to be_nil

  expect(podcast['episodios'].first['id']).not_to be_nil
end

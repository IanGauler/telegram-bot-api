Dado('que el anio actual es {string}') do |anio|
  @anio = anio
  @contenido ||= {}
  allow(Time).to receive(:now).and_return(Time.new(anio.to_i))
end

Dado('que el podcast tiene {string} vacio') do |key|
  @contenido[key] = ''
end

Dado('que el podcast tiene por {string} a {string}') do |key, valor|
  @contenido[key] = valor
end

Dado('que el podcast tiene {string} episodio valido') do |cantidad_episodios|
  episodios = []
  cantidad_episodios.to_i.times do |i|
    episodios << { titulo: "Episodio #{i}", participantes: "Participante #{i}", duracion: '39:50' }
  end
  @contenido[:episodios] = episodios
end

Cuando('publico en la API con {string} el contenido') do |endpoint|
  podcasts = [@contenido].to_json
  @response = Faraday.post(endpoint, podcasts, { 'Content-Type' => 'application/json' })
end

Entonces('obtengo el error {string}') do |error|
  expect(@response.status).to eq(400)
  response_body = JSON.parse(@response.body)
  expect(response_body['error']).to eq(error)
end

Dado('que quiero agregar un podcast válido con un episodio a la plataforma') do
  @podcasts = [{
    titulo: 'Podcast de prueba',
    creador: 'Creador de un podcast de prueba',
    anio: 2024,
    episodios: [
      {
        titulo: '',
        participantes: '',
        duracion: ''
      }
    ]
  }]
end

Dado('que el episodio tiene {string} vacio') do |parametro|
  @podcasts.first[:episodios].first[parametro.to_sym] = ''
end

Dado('que el episodio tiene por {string} a {string}') do |parametro, valor|
  @podcasts.first[:episodios].first[parametro.to_sym] = valor
end

Entonces('el podcast es dado de alta') do
  expect(@response.status).to eq(201)
end

Dado('que la cancion tiene {string} vacio') do |parametro|
  @contenido[parametro] = ''
end

Dado('que la cancion tiene por {string}: {string}') do |parametro, valor|
  @contenido[parametro] = valor
end

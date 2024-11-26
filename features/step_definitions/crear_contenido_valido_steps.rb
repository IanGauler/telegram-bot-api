Dado('que el anio actual es {string}') do |anio|
  @anio = anio
  allow(Time).to receive(:now).and_return(Time.new(anio.to_i))
end

Dado('que el podcast tiene {string} vacio') do |key|
  @podcast ||= {}
  @podcast[key] = ''
end

Dado('que el podcast tiene por {string} a {string}') do |key, valor|
  @podcast[key] = valor
end

Dado('que el podcast tiene {string} episodio valido') do |cantidad_episodios|
  episodios = []
  cantidad_episodios.to_i.times do |i|
    episodios << { titulo: "Episodio #{i}", participantes: "Participante #{i}", duracion: "39:50:#{i}" }
  end
  @podcast[:episodios] = episodios
end

Cuando('publico en la API con {string} el contenido') do |endpoint|
  podcasts = [@podcast].to_json
  @response = Faraday.post(endpoint, podcasts, { 'Content-Type' => 'application/json' })
end

Entonces('obtengo el error {string}') do |error|
  expect(@response.status).to eq(400)
  response_body = JSON.parse(@response.body)
  expect(response_body['error']).to eq(error)
end

Dado('que en la plataforma no hay canciones') do
  RepositorioCanciones.new.delete_all
  @canciones = []
end

Cuando('envío el comando {string}') do |comando|
  @response = Faraday.get(comando)
end

Entonces('el bot muestra el mensaje {string}.') do |_mensaje_esperado|
  expect(@response.status).to eq(200)
end

Dado('que en la plataforma existen {string}, {string}, {string}') do |titulo1, titulo2, titulo3|
  repositorio_canciones = RepositorioCanciones.new
  repositorio_canciones.delete_all

  @canciones = []

  [titulo1, titulo2, titulo3].each do |titulo|
    cancion = Cancion.new(titulo, 'Artista', 2020, '2:00')
    @canciones << cancion
    repositorio_canciones.save(cancion)
  end
end

Entonces('el bot muestra {string} canciones') do |cantidad_canciones, _canciones_esperadas|
  response_body = JSON.parse(@response.body)

  cantidad_canciones.to_i.times do |i|
    cancion = response_body[i]
    expect(cancion['titulo']).to eq(@canciones[i].titulo)
  end
  expect(@response.status).to eq(200)
end

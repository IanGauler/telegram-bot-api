Dado('que existe la cancion {string}') do |titulo_cancion|
  cancion = Cancion.new(titulo_cancion, 'Shakira', 2010, '3:31')
  repositorio_canciones = RepositorioCanciones.new
  repositorio_canciones.save(cancion)
end

Cuando('envío el comando {string} con el id de la cancion WakaWaka') do |_comando|
  id_cancion = RepositorioCanciones.new.all.first.id
  @response = Faraday.get("contenidos/#{id_cancion}")
end

Entonces('el bot muestra los detalles') do |_doc_string|
  response_body = JSON.parse(@response.body)
  expect(response_body).to have_key('titulo')
  expect(response_body).to have_key('artistas')
  expect(response_body).to have_key('anio')
  expect(response_body).to have_key('duracion')
  expect(@response.status).to eq(200)
end

Cuando('envio el comando {string} con el id de una cancion inexistente') do |_string|
  @response = Faraday.get('contenidos/-1')
end

Entonces('el bot muestra el mensaje de error {string}') do |mensaje_error|
  response_body = JSON.parse(@response.body)
  expect(@response.status).to eq(404)
  expect(response_body['error']).to eq(mensaje_error)
end

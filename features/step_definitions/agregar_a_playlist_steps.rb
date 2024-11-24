Dado('que mi playlist esta vacia') do
  # no hay nada que hacer
end

Cuando('envio el comando {string} con id inexistente') do |_comando|
  request_body = { id_usuario: @id_usuario }.to_json
  @response = Faraday.post('/contenidos/-1/playlist', request_body, { 'Content-Type' => 'application/json' })
end

Cuando('intento agregar a la playlist {string}') do |titulo_contenido|
  contenido_id = RepositorioContenido.new.all.find { |contenido| contenido.titulo == titulo_contenido }.id
  request_body = { id_usuario: @id_usuario }.to_json

  @response = Faraday.post("/contenidos/#{contenido_id}/playlist", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('el {string} se agrega a mi playlist') do |titulo|
  usuario = RepositorioUsuarios.new.all.first
  puts "que tiene la playlist: #{usuario.playlist.contenidos}"
  contenido = usuario.playlist.contenidos.first

  expect(@response.status).to eq(201)
  expect(contenido.titulo).to eq(titulo)
end

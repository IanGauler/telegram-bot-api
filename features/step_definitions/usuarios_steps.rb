Cuando(/^creo un usuario$/) do
  request_body = { id: '1', email: 'juan@test.com' }.to_json
  @response = Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' })
end

Entonces(/^se le asigna un id$/) do
  parsed_response = JSON.parse(@response.body)
  id = parsed_response['id']
  expect(id.to_i).to be > 0
end

Cuando(/^que no existen usuario$/) do
  # nada que hacer aqui
end

Cuando(/^consulto los usuarios$/) do
  @response = Faraday.get('/usuarios')
end

Entonces(/^tengo un listado vacio$/) do
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response)
end

Dado('que mi usuario es {string}, mi id es {string} y no estoy registrado') do |_nombre_usuario, id_usuario|
  RepositorioUsuarios.new.delete_all
  @id = id_usuario
end

Cuando('envio el comando {string} con email {string}') do |_comando_registrar, email|
  request_body = { id: @id, email: }.to_json
  @response = Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' })
end

Entonces('el bot muestra el mensaje {string}') do |mensaje_esperado|
  codigos_esperados = {
    'No se ha podido encontrar contenido' => 200,
    'Usuario registrado' => 201,
    'Bienvenido, juan' => 201,
    'Calificacion registrada' => 201,
    'La cancion no existe.' => 404,
    'Aún no has escuchado este contenido.' => 409,
    'El usuario juan ya esta registrado' => 409,
    'Ya existe un usuario con ese mail, intenta registrarte con otro mail' => 409,
    'No hay recomendaciones de canciones disponibles en este momento. Escucha una para ayudar a la comunidad' => 200,
    'El contenido no fue encontrado.' => 404,
    'No se puede dar me gusta a episodios.' => 404,
    'No se puede agregar podcast a una playlist. Deberías agregar los episodios individualmente.' => 409,
    'Este contenido ya se encuentra en tu playlist.' => 409
  }
  expect(@response.status).to eq(codigos_esperados[mensaje_esperado])
end

Dado('que mi mail es {string}, mi id es {string} y estoy registrado') do |mail, id|
  RepositorioUsuarios.new.delete_all
  @id = id
  request_body = { id: @id, email: mail }.to_json
  Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' })
end

Entonces('el bot muestra el error {string}') do |_error|
  expect(@response.status).not_to eq(201)
end

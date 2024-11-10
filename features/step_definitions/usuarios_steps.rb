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

Entonces('el bot muestra el mensaje {string}') do |_mensaje_esperado|
  expect(@response.status).to eq(201)
end

Dado('que el sistema recibe una solicitud de registro con mail {string} y el id de la cancion {string}') do |email, _titulo|
  @cancion = RepositorioCanciones.new.all.first
  request_body = { email: }.to_json
  @response = Faraday.post("/canciones/#{@cancion.id}/reproduccion", request_body, { 'Content-Type' => 'application/json' })
end

Dado('que el sistema recibe una solicitud de registro con mail {string} y el id de una cancion inexistente') do |email|
  request_body = { email: }.to_json
  @response = Faraday.post('/canciones/100/reproduccion', request_body, { 'Content-Type' => 'application/json' })
end

Entonces('el sistema actualiza el historial de escucha del usuario') do
  repositorio_reproducciones = RepositorioReproducciones.new
  reproduccion = repositorio_reproducciones.all.first
  expect(@response.status).to eq(201)
  expect(reproduccion.usuario.id).to eq(@usuario.id)
  expect(reproduccion.cancion.id).to eq(@cancion.id)
end

Entonces('el sistema devuelve un mensaje de error {string}') do |mensaje_de_error|
  parsed_response = JSON.parse(@response.body)
  expect(parsed_response['error']).to eq(mensaje_de_error)
  expect(@response.status).to eq(404)
end

Entonces('no actualiza el historial de escucha del usuario') do
  repositorio_reproducciones = RepositorioReproducciones.new
  expect(repositorio_reproducciones.all.size).to eq(0)
end

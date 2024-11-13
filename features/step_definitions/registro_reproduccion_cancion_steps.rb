Dado('que el sistema recibe una solicitud de registro con mail {string} y el id de la cancion {string}') do |email, _titulo|
  @cancion = RepositorioCanciones.new.all.first
  request_body = { email:, id_cancion: @cancion.id }.to_json
  @response = Faraday.post('/reproduccion', request_body, { 'Content-Type' => 'application/json' })
end

Entonces('el sistema actualiza el historial de escucha del usuario') do
  repositorio_reproducciones = RepositorioReproducciones.new
  reproduccion = repositorio_reproducciones.all.first

  expect(reproduccion.id_usuario).to eq(@usuario.id)
  expect(reproduccion.id_cancion).to eq(@cancion.id)
  expect(@response.status).to eq(201)
end

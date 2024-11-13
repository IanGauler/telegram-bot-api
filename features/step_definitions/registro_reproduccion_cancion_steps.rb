Dado('que el sistema recibe una solicitud de registro con mail {string} y el id de la cancion {string}') do |email, _titulo|
  cancion = RepositorioCanciones.new.all.first
  request_body = { email:, id_cancion: cancion.id }.to_json
  @response = Faraday.post('/reproduccion', request_body, { 'Content-Type' => 'application/json' })
end

Entonces('el sistema actualiza el historial de escucha del usuario') do
  repositorio_reproducciones = RepositorioReproducciones.new
  reproducciones = repositorio_reproducciones.all

  expect(reproducciones.first.usuario_id).to eq(email)
  expect(reproducciones.first.cancion_id).to eq(id_cancion)
  expect(@response.status).to eq(201)
end

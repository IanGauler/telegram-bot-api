Dado('que he reproducido la cancion {string}') do |_cancion|
  @id_cancion = RepositorioCanciones.new.all.first.id
  @id_usuario = RepositorioUsuarios.new.all.first.id
  reproduccion = Reproduccion.new(@id_usuario, @id_cancion)
  RepositorioReproducciones.new.save(reproduccion)
end

Cuando('envio el comando {string} con la id de {string}') do |_comando, cancion|
  @id_cancion ||= RepositorioCanciones.new.all.first.id
  @id_cancion = 0 if cancion == 'Cancion Inexistente'
  request_body = { id_cancion: @id_cancion, id_usuario: @id_usuario }.to_json
  @response = Faraday.post('/megusta', request_body, { 'Content-Type' => 'application/json' })
end

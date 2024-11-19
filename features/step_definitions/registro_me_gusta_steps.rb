Dado('que he reproducido la cancion {string}') do |_cancion|
  @id_cancion = RepositorioCanciones.new.all.first.id
  @id_usuario = RepositorioUsuarios.new.all.first.id

  usuario = RepositorioUsuarios.new.find(@id_usuario)
  cancion = RepositorioCanciones.new.find(@id_cancion)

  reproduccion = Reproduccion.new(usuario, cancion)
  RepositorioReproducciones.new.save(reproduccion)
end

Cuando('envio el comando {string} con la id de {string}') do |_comando, cancion|
  @id_cancion = RepositorioCanciones.new.all.first.id
  @id_cancion = 0 if cancion == 'Cancion Inexistente'
  request_body = { id_usuario: @id_usuario }.to_json
  @response = Faraday.post("/canciones/#{@id_cancion}/megusta", request_body, { 'Content-Type' => 'application/json' })
end

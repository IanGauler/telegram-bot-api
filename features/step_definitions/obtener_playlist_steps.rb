Dado('que agregue a mi playlist {string}') do |titulo_contenido|
  contenido_id = RepositorioContenido.new.all.find { |contenido| contenido.titulo == titulo_contenido }.id
  request_body = { id_usuario: @id_usuario }.to_json
  @response = Faraday.post("/contenidos/#{contenido_id}/playlist", request_body, { 'Content-Type' => 'application/json' })
end

Cuando('envio el comando {string}') do |_string|
  @response = Faraday.get("/usuarios/#{@id_usuario}/playlist")
end

Entonces('el bot muestra el mensaje') do |contenidos_playlist|
  contenidos = JSON.parse(@response.body)

  contenidos.each do |contenido|
    expect(contenidos_playlist).to include(contenido['titulo'])
  end
end

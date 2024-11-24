Dado('que mi playlist esta vacia') do
  # no hay nada que hacer
end

Cuando('envio el comando {string} con id inexistente') do |_comando|
  request_body = { id_usuario: @id_usuario }.to_json
  @response = Faraday.post('/contenidos/1/playlist', request_body, { 'Content-Type' => 'application/json' })
end

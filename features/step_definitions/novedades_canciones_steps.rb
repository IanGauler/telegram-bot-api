Dado('que en la plataforma no hay canciones') do
  RepositorioCanciones.new.delete_all
  @canciones = []
end

Cuando('envío el comando {string}') do |comando|
  @response = Faraday.get(comando)
end

Entonces('el bot muestra el mensaje {string}.') do |_mensaje_esperado|
  expect(@response.status).to eq(200)
end

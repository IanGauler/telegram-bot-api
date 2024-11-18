Dado('que no hay contenido en el sistema') do
  # nada que hacer
end

Dado('que existe la canción {string}') do |titulo|
  @cancion = Cancion.new(titulo, 'Shakira', 2010, '3:31')
  RepositorioCanciones.new.save(cancion)
end

Entonces('me recomienda {string}') do |titulo|
  response_body = JSON.parse(@response.body)
  novedad = response_body.find { |c| c['titulo'] == titulo }
  expect(novedad).not_to be_nil
end

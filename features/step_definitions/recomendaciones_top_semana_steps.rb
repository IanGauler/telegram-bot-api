require 'cucumber/rspec/doubles'

Dado('que hoy es un dia de la semana laboral') do
  allow(Date).to receive(:today).and_return(Date.new(2024, 11, 14))
end

Dado('que las primeras {string} son las mas escuchadas de las semana laboral') do |cantidad_canciones|
  repositorio_reproducciones = RepositorioReproducciones.new
  repositorio_reproducciones.delete_all
  @usuario = Usuario.new('100', 'mail@mail.com')
  RepositorioUsuarios.new.save(@usuario)
  @id_usuario = RepositorioUsuarios.new.all.first.id

  cantidad_canciones.to_i.times do |i|
    reproduccion = Reproduccion.new(@id_usuario, @canciones[i].id)
    repositorio_reproducciones.save(reproduccion)
  end
end

Entonces('el bot muestra las primeras {string} canciones') do |string|
  response_body = JSON.parse(@response.body)

  string.to_i.times do |i|
    expect(response_body.any? { |c| c['titulo'] == @canciones[i].titulo }).to be true
  end
end

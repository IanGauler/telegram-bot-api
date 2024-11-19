require 'cucumber/rspec/doubles'

Dado('que hoy es un dia de la semana laboral') do
  @mock_dia_semana = proc { allow(Date).to receive(:today).and_return(Date.new(2024, 11, 14)) }
  @mock_dia_semana.call
end

Dado('que las primeras {string} son las mas escuchadas de las semana laboral') do |cantidad_canciones|
  @repositorio_reproducciones = RepositorioReproducciones.new
  @repositorio_reproducciones.delete_all

  @usuario = Usuario.new('100', 'mail@mail.com')
  RepositorioUsuarios.new.save(@usuario)

  @id_usuario = RepositorioUsuarios.new.all.first.id
  @canciones_reproducidas = cantidad_canciones.to_i

  cantidad_canciones.to_i.times do |i|
    reproduccion = Reproduccion.new(@usuario, @canciones[i])
    @repositorio_reproducciones.save(reproduccion)
  end
end

Dado('que las otras {string} fueron escuchadas el fin de semana') do |cantidad_canciones|
  allow(Date).to receive(:today).and_return(Date.new(2024, 11, 17))

  cantidad_canciones.to_i.times do |i|
    reproduccion = Reproduccion.new(@usuario, @canciones[@canciones_reproducidas + i])
    @repositorio_reproducciones.save(reproduccion)
  end
end

Entonces('el bot muestra las primeras {string} canciones') do |cantidad_canciones|
  response_body = JSON.parse(@response.body)
  cantidad_canciones.to_i.times do |i|
    expect(response_body.any? { |c| c['titulo'] == @canciones[i].titulo }).to be true
  end
end

Dado('que hoy es un dia del fin de semana') do
  @mock_dia_semana = proc { allow(Date).to receive(:today).and_return(Date.new(2024, 11, 17)) }
  @mock_dia_semana.call
end

Dado('que las primeras {string} son las mas escuchadas de los fines de semana') do |cantidad_canciones|
  @repositorio_reproducciones = RepositorioReproducciones.new
  @repositorio_reproducciones.delete_all

  @usuario = Usuario.new('100', 'mail@mail.com')
  RepositorioUsuarios.new.save(@usuario)

  @id_usuario = RepositorioUsuarios.new.all.first.id
  @canciones_reproducidas = cantidad_canciones.to_i

  cantidad_canciones.to_i.times do |i|
    reproduccion = Reproduccion.new(@usuario, @canciones[i])
    @repositorio_reproducciones.save(reproduccion)
  end
end

Dado('que las otras {string} fueron escuchadas en la semana laboral') do |cantidad_canciones|
  allow(Date).to receive(:today).and_return(Date.new(2024, 11, 14))

  cantidad_canciones.to_i.times do |i|
    reproduccion = Reproduccion.new(@usuario, @canciones[@canciones_reproducidas + i])
    @repositorio_reproducciones.save(reproduccion)
  end
end

Dado('que no hay canciones escuchadas durante la semana laboral') do
  RepositorioReproducciones.new.delete_all
end

Dado('que las otras {string} no tienen reproducciones') do |_cantidad_canciones|
end

Dado('que tengo un usuario en el sistema') do
  @usuario = Usuario.new(1, 'juan@gmail.com')
  RepositorioUsuarios.new.save(@usuario)
end

Cuando('pido post reset') do
  body = {}
  @response = Faraday.post('/reset', body, { 'Content-Type' => 'application/json' })
end

Entonces('se eliminan todos los usuarios') do
  expect(@response.status).to eq(200)
  expect(RepositorioUsuarios.new.all).to eq([])
end

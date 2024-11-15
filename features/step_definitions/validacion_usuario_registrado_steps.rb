Dado('que mi usuario es {string}, mi id es {string}, mi mail es {string} y estoy registrado') do |_nombre, id, mail|
  @usuario = Usuario.new(id, mail)
  @id = id
  RepositorioUsuarios.new.save(@usuario)
end

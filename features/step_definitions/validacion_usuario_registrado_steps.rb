Dado('que mi usuario es {string} con id {string} y mail {string}, y estoy registrado') do |_nombre, id, mail|
  @usuario = Usuario.new(id, mail)
  @id_usuario = id
  RepositorioUsuarios.new.save(@usuario)
end

Dado('existe un usuario registrado con el mail {string}') do |email|
  @usuario = Usuario.new('100', email)
  RepositorioUsuarios.new.save(@usuario)
end

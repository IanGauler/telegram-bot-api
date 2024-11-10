class Sistema
  def initialize(repositorio_usuarios)
    @repositorio_usuarios = repositorio_usuarios
  end

  def crear_usuario(id, email)
    usuario = Usuario.new(id, email)
    @repositorio_usuarios.save(usuario)
    usuario
  end

  def usuarios
    @repositorio_usuarios.all
  end

  def eliminar_usuarios
    @repositorio_usuarios.delete_all
  end
end

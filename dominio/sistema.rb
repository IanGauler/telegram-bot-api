class Sistema
  def initialize(repositorio_usuarios)
    @repositorio_usuarios = repositorio_usuarios
  end

  def crear_usuario(id, email)
    usuario = Usuario.new(id, email)
    raise UsuarioYaRegistrado, 'Usuario ya registrado' if @repositorio_usuarios.existe_usuario?(usuario)

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

class UsuarioYaRegistrado < StandardError; end

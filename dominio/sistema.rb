class Sistema
  def initialize(repositorio_usuarios, repositorio_canciones)
    @repositorio_usuarios = repositorio_usuarios
    @repositorio_canciones = repositorio_canciones
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

  def crear_cancion(titulo, artista, anio, duracion)
    cancion = Cancion.new(titulo, artista, anio, duracion)
    @repositorio_canciones.save(cancion)
  end
end

class UsuarioYaRegistrado < StandardError; end

class Sistema
  CANTIDAD_NOVEDADES = 5
  def initialize(repositorio_usuarios, repositorio_canciones, repositorio_reproducciones, repositorio_megustas)
    @repositorio_usuarios = repositorio_usuarios
    @repositorio_canciones = repositorio_canciones
    @repositorio_reproducciones = repositorio_reproducciones
    @repositorio_megustas = repositorio_megustas
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

  def resetear
    @repositorio_usuarios.delete_all
    @repositorio_canciones.delete_all
  end

  def crear_cancion(titulo, artista, anio, duracion)
    cancion = Cancion.new(titulo, artista, anio, duracion)
    @repositorio_canciones.save(cancion)
  end

  def canciones
    @repositorio_canciones.all
  end

  def obtener_novedades
    @repositorio_canciones.ultimas_canciones(CANTIDAD_NOVEDADES)
  end

  def obtener_datos_cancion_por_id(id)
    cancion = @repositorio_canciones.obtener_cancion_por_id(id)
    raise CancionNoEncontrada if cancion.nil?

    cancion
  end

  def registrar_reproduccion(email, id_cancion)
    usuario = @repositorio_usuarios.obtener_usuario_por_email(email)
    raise UsuarioNoRegistrado if usuario.nil?

    cancion = @repositorio_canciones.obtener_cancion_por_id(id_cancion)
    raise CancionNoEncontrada if cancion.nil?

    reproduccion = Reproduccion.new(usuario.id, id_cancion)
    @repositorio_reproducciones.save(reproduccion)
  end

  def registrar_megusta(id_usuario, id_cancion)
    cancion = @repositorio_canciones.obtener_cancion_por_id(id_cancion)

    raise CancionNoEncontrada if cancion.nil?

    raise CancionNoEscuchada unless @repositorio_reproducciones.existe_reproduccion?(id_usuario, id_cancion)

    megusta = Megusta.new(id_usuario, id_cancion)
    @repositorio_megustas.save(megusta)
  end

  def reproducciones
    @repositorio_reproducciones.all
  end
end

class UsuarioYaRegistrado < StandardError
  def initialize(msg = 'Usuario ya registrado')
    super(msg)
  end
end

class CancionNoEncontrada < StandardError
  def initialize(msg = 'La cancion no fue encontrada.')
    super(msg)
  end
end

class UsuarioNoRegistrado < StandardError
  def initialize(msg = 'El usuario no fue encontrado.')
    super(msg)
  end
end

class CancionNoEscuchada < StandardError
  def initialize(msg = 'El usuario aún no ha escuchado esta cancion.')
    super(msg)
  end
end

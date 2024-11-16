require_relative './modulos_sistema/sistema_canciones'
require_relative './modulos_sistema/sistema_megusta'
require_relative './modulos_sistema/sistema_reproducciones'
class Sistema
  include SistemaCanciones
  include SistemaMeGusta
  include SistemaReproducciones
  CANTIDAD_NOVEDADES = 5
  def initialize(repositorio_usuarios, repositorio_canciones, repositorio_reproducciones, repositorio_megustas)
    @repositorio_usuarios = repositorio_usuarios
    @repositorio_canciones = repositorio_canciones
    @repositorio_reproducciones = repositorio_reproducciones
    @repositorio_megustas = repositorio_megustas
  end

  def crear_usuario(id, email)
    usuario = Usuario.new(id.to_s, email)
    raise UsuarioYaRegistrado if @repositorio_usuarios.existe_usuario_con_id?(usuario)
    raise MailYaRegistrado unless @repositorio_usuarios.obtener_usuario_por_email(email).nil?

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

  def obtener_novedades
    @repositorio_canciones.ultimas_canciones(CANTIDAD_NOVEDADES)
  end

  def obtener_datos_cancion_por_id(id)
    cancion = @repositorio_canciones.obtener_cancion_por_id(id)
    raise CancionNoEncontrada if cancion.nil?

    cancion
  end

  def reproducciones
    @repositorio_reproducciones.all
  end

  def megustas
    @repositorio_megustas.all
  end
end

class UsuarioYaRegistrado < StandardError
  def initialize(msg = 'Usuario ya registrado')
    super(msg)
  end
end

class MailYaRegistrado < StandardError
  def initialize(msg = 'Mail ya registrado')
    super(msg)
  end
end

class UsuarioNoRegistrado < StandardError
  def initialize(msg = 'El usuario no fue encontrado.')
    super(msg)
  end
end

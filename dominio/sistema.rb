Dir[File.join(__dir__, './errores', '*.rb')].each { |file| require file }
require_relative './novedades'
require_relative './recomendaciones'

class Sistema
  CANTIDAD_NOVEDADES = 5
  def initialize(repositorio_usuarios, administrador_de_contenido, repositorio_reproducciones, repositorio_megustas)
    @repositorio_usuarios = repositorio_usuarios
    @administrador_de_contenido = administrador_de_contenido
    @repositorio_reproducciones = repositorio_reproducciones
    @repositorio_megustas = repositorio_megustas
  end

  def resetear
    @repositorio_usuarios.delete_all
    @administrador_de_contenido.resetear
  end

  def usuarios
    @repositorio_usuarios.all
  end

  def crear_usuario(id, email)
    usuario = Usuario.new(id, email)
    usuario.esta_registradado?(@repositorio_usuarios)
    @repositorio_usuarios.save(usuario)
    usuario
  end

  def obtener_novedades
    novedades = Novedades.new(CANTIDAD_NOVEDADES)
    novedades.listar(@administrador_de_contenido.repositorio_contenidos)
  end

  def recomendaciones_de_la_semana
    Recomendaciones.new.de_la_semana(Date.today, @administrador_de_contenido.repositorio_canciones)
  end

  def canciones
    @administrador_de_contenido.repositorio_canciones.all
  end

  def crear_cancion(titulo, artista, anio, duracion)
    cancion = Cancion.new(titulo, artista, anio, duracion)
    @administrador_de_contenido.repositorio_canciones.save(cancion)
  end

  def obtener_contenido_por_id(id)
    @administrador_de_contenido.repositorio_contenidos.find(id)
  rescue ObjectNotFound
    raise ContenidoNoEncontrado
  end

  def crear_podcast(titulo, creador, anio, episodios)
    podcast = Podcast.new(titulo, creador, anio)

    episodios.map do |episodio|
      episodio = Episodio.new(podcast, episodio[:titulo], episodio[:participantes], episodio[:duracion])
      podcast.agregar_episodios(episodio)
    end

    @administrador_de_contenido.repositorio_podcasts.save(podcast)
  end

  def podcasts
    @administrador_de_contenido.repositorio_podcasts.all
  end

  def reproducciones
    @repositorio_reproducciones.all
  end

  def megustas
    @repositorio_megustas.all
  end

  def registrar_megusta(id_usuario, id_contenido)
    cancion = obtener_contenido_por_id(id_contenido)
    usuario = @repositorio_usuarios.obtener_usuario_por_id(id_usuario)

    raise UsuarioNoRegistrado if usuario.nil?

    usuario.dar_megusta_a(cancion)
    @repositorio_usuarios.save(usuario)
  end

  def registrar_reproduccion(email, id_contenido)
    contenido = obtener_contenido_por_id(id_contenido)
    usuario = @repositorio_usuarios.obtener_usuario_por_email(email)

    raise UsuarioNoRegistrado if usuario.nil?

    usuario.reproducir(contenido)
    @repositorio_usuarios.save(usuario)
  end

  def registrar_reproduccion_episodio(email, id_episodio, id_podcast)
    episodio = obtener_contenido_por_id_repositorio(@administrador_de_contenido.repositorio_episodios, id_episodio)
    podcast = obtener_contenido_por_id_repositorio(@administrador_de_contenido.repositorio_podcasts, id_podcast)
    podcast.tiene_episodio(episodio)

    registrar_reproduccion(email, id_episodio)
  end

  def agregar_contenido_a_playlist(id_usuario, id_contenido)
    contenido = obtener_contenido_por_id(id_contenido)
    usuario = @repositorio_usuarios.obtener_usuario_por_id(id_usuario)

    usuario.agregar_contenido_a_playlist(contenido)
  end

  private

  def obtener_contenido_por_id_repositorio(repositorio, id)
    repositorio.find(id)
  rescue ObjectNotFound
    raise ContenidoNoEncontrado
  end
end

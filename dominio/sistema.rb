Dir[File.join(__dir__, './errores', '*.rb')].each { |file| require file }
require_relative './novedades'

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
    raise UsuarioYaRegistrado if @repositorio_usuarios.existe_usuario_con_id?(usuario)
    raise MailYaRegistrado unless @repositorio_usuarios.obtener_usuario_por_email(email).nil?

    @repositorio_usuarios.save(usuario)
    usuario
  end

  def obtener_novedades
    novedades = Novedades.new(CANTIDAD_NOVEDADES)
    novedades.listar(@administrador_de_contenido.repositorio_contenidos)
  end

  def recomendaciones_de_la_semana
    @administrador_de_contenido.repositorio_canciones.canciones_top_semana(Date.today)
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
    @administrador_de_contenido.repositorio_podcasts.save(podcast)
    crear_episodios(episodios, podcast)
  end

  def podcasts
    podcasts = @administrador_de_contenido.repositorio_podcasts.all

    podcasts.map do |podcast|
      episodios = @administrador_de_contenido.repositorio_episodios.obtener_episodios_por_podcast(podcast.id)
      podcast.agregar_episodios(episodios)
    end

    podcasts
  end

  def reproducciones
    @repositorio_reproducciones.all
  end

  def registrar_reproduccion(email, contenido)
    usuario = @repositorio_usuarios.obtener_usuario_por_email(email)

    reproduccion = Reproduccion.new(usuario, contenido)
    @repositorio_reproducciones.save(reproduccion)
  end

  def megustas
    @repositorio_megustas.all
  end

  def registrar_megusta(id_usuario, id_cancion)
    cancion = @administrador_de_contenido.repositorio_canciones.obtener_cancion_por_id(id_cancion)
    usuario = @repositorio_usuarios.obtener_usuario_por_id(id_usuario)
    raise CancionNoEncontrada if cancion.nil?
    raise UsuarioNoRegistrado if usuario.nil?

    reproduccion = @repositorio_reproducciones.obtener_reproduccion(usuario, cancion)
    megusta = MeGusta.new(usuario, cancion, reproduccion)
    @repositorio_megustas.save(megusta)
  end

  private

  def crear_episodios(episodios, podcast)
    episodios.each do |episodio|
      episodio = Episodio.new(podcast, episodio[:titulo], episodio[:participantes], episodio[:duracion])
      @administrador_de_contenido.repositorio_episodios.save(episodio)
    end
  end
end

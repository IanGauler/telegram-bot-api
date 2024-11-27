Dir[File.join(__dir__, './errores', '*.rb')].each { |file| require file }
require_relative './novedades'
require_relative './recomendaciones'

class Sistema
  CANTIDAD_NOVEDADES = 5
  CANTIDAD_RECOMENDACIONES = 5
  def initialize(repositorio_usuarios, administrador_de_contenido, repositorio_reproducciones, repositorio_megustas, proveedor_de_artistas)
    @repositorio_usuarios = repositorio_usuarios
    @administrador_de_contenido = administrador_de_contenido
    @repositorio_reproducciones = repositorio_reproducciones
    @repositorio_megustas = repositorio_megustas
    @proveedor_de_artistas = proveedor_de_artistas
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
    nuevos_episodios = episodios.map do |episodio|
      Episodio.new(episodio[:titulo], episodio[:participantes], episodio[:duracion])
    end

    podcast = Podcast.new(titulo, creador, anio, nuevos_episodios)

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
    contenido = obtener_contenido_por_id(id_contenido)
    usuario = @repositorio_usuarios.obtener_usuario_por_id(id_usuario)

    raise UsuarioNoRegistrado if usuario.nil?

    usuario.dar_megusta_a(contenido)
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
    @repositorio_usuarios.save(usuario)

    contenido
  end

  def obtener_playlist(id_usuario)
    usuario = @repositorio_usuarios.obtener_usuario_por_id(id_usuario)
    raise UsuarioNoRegistrado if usuario.nil?

    usuario.playlist
  end

  def recomendar_artistas(id_usuario)
    usuario = @repositorio_usuarios.obtener_usuario_por_id(id_usuario)
    raise UsuarioNoRegistrado if usuario.nil?

    reproducciones = @repositorio_reproducciones.obtener_reproducciones_de_usuario(usuario)
    artistas_escuchados = obtener_escuchas_por_artista(reproducciones)
    raise ContenidoNoEscuchado, 'No hay reproducciones sobre las cuales recomendar' if artistas_escuchados.empty?

    top_artista = artistas_escuchados.max_by { |_k, v| v }.first
    @proveedor_de_artistas.artistas_similares(top_artista, CANTIDAD_RECOMENDACIONES)
  rescue ErrorConectorRecomendaciones
    raise RecomendacionesNoDisponibles
  end
end

def obtener_escuchas_por_artista(reproducciones)
  artistas_escuchados = {}
  reproducciones_canciones = reproducciones.select { |reproduccion| reproduccion.contenido.is_a?(Cancion) }
  reproducciones_canciones.each do |reproduccion|
    artistas = reproduccion.contenido.artistas_participantes
    artistas.each do |autor|
      artistas_escuchados[autor] ||= 0
      artistas_escuchados[autor] += 1
    end
  end
  artistas_escuchados
end

def obtener_contenido_por_id_repositorio(repositorio, id)
  repositorio.find(id)
rescue ObjectNotFound
  raise ContenidoNoEncontrado
end

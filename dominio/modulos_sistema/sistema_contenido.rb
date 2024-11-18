module SistemaContenido
  def canciones
    @administrador_de_contenido.repositorio_canciones.all
  end

  def crear_cancion(titulo, artista, anio, duracion)
    cancion = Cancion.new(titulo, artista, anio, duracion)
    @administrador_de_contenido.repositorio_canciones.save(cancion)
  end

  def obtener_contenido_por_id(id)
    cancion = @administrador_de_contenido.repositorio_canciones.obtener_cancion_por_id(id)
    raise CancionNoEncontrada if cancion.nil?

    cancion
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

  private

  def crear_episodios(episodios, podcast)
    episodios.each do |episodio|
      episodio = Episodio.new(podcast, episodio[:titulo], episodio[:participantes], episodio[:duracion])
      @administrador_de_contenido.repositorio_episodios.save(episodio)
    end
  end
end

class ErrorCancion < StandardError
end

class CancionNoEncontrada < ErrorCancion
  def initialize(msg = 'La cancion no fue encontrada.')
    super(msg)
  end
end

class CancionNoEscuchada < ErrorCancion
  def initialize(msg = 'El usuario aún no ha escuchado esta cancion.')
    super(msg)
  end
end

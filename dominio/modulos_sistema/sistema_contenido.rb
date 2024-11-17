module SistemaContenido
  def canciones
    @administrador_de_contenido.repositorio_canciones.all
  end

  def crear_cancion(titulo, artista, anio, duracion)
    cancion = Cancion.new(titulo, artista, anio, duracion)
    @administrador_de_contenido.repositorio_canciones.save(cancion)
  end

  def obtener_datos_cancion_por_id(id)
    cancion = @administrador_de_contenido.repositorio_canciones.obtener_cancion_por_id(id)
    raise CancionNoEncontrada if cancion.nil?

    cancion
  end

  def crear_podcast(titulo, creador, anio, episodios)
    podcast = Podcast.new(titulo, creador, anio)
    puts 'podcast creado'
    @administrador_de_contenido.repositorio_podcasts.save(podcast)
    puts 'podcast guardado'
    crear_episodios(episodios, podcast)
  end

  private

  def crear_episodios(episodios, podcast)
    episodios.each do |episodio|
      puts "episodio: #{episodio.inspect}"
      episodio = Episodio.new(podcast.id, episodio[:titulo], episodio[:participantes], episodio[:duracion])
      puts 'episodio creado'
      @administrador_de_contenido.repositorio_episodios.save(episodio)
      puts 'episodio guardado'
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

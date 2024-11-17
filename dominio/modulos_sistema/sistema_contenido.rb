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

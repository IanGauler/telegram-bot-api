class ErrorContenido < StandardError
end

class ContenidoNoEncontrado < ErrorContenido
  def initialize(msg = 'El contenido no fue encontrado.')
    super(msg)
  end
end

class CancionNoEscuchada < ErrorContenido
  def initialize(msg = 'El usuario aún no ha escuchado esta cancion.')
    super(msg)
  end
end

class CancionNoEncontrada < ErrorContenido
  def initialize(msg = 'La canción no fue encontrada.')
    super(msg)
  end
end

class EpisodioNoPerteneceAPodcast < ErrorContenido
  def initialize(msg = 'El episodio no pertenece al podcast.')
    super(msg)
  end
end

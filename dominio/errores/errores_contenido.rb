class ErrorCancion < StandardError
end

class ContenidoNoEncontrado < ErrorCancion
  def initialize(msg = 'El contenido no fue encontrado.')
    super(msg)
  end
end

class CancionNoEscuchada < ErrorCancion
  def initialize(msg = 'El usuario aún no ha escuchado esta cancion.')
    super(msg)
  end
end

class CancionNoEncontrada < ErrorCancion
  def initialize(msg = 'La canción no fue encontrada.')
    super(msg)
  end
end

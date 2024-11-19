class Reproduccion
  attr_accessor :id
  attr_reader :cancion, :usuario, :updated_on, :created_on

  def initialize(usuario, cancion, id = nil)
    @usuario = usuario
    @cancion = cancion
    @id = id
    validar_reproduccion!
  end

  def validar_reproduccion!
    raise UsuarioNoRegistrado if usuario.nil?
    raise ContenidoNoEncontrado if cancion.nil?
  end
end

class ErrorUsuario < StandardError
end

class UsuarioNoRegistrado < ErrorUsuario
  def initialize(msg = 'El usuario no fue encontrado.')
    super(msg)
  end
end

class ErrorCancion < StandardError
end

class ContenidoNoEncontrado < ErrorCancion
  def initialize(msg = 'El contenido no fue encontrado.')
    super(msg)
  end
end

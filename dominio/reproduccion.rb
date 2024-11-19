require_relative './errores/errores_contenido'

class Reproduccion
  attr_accessor :id
  attr_reader :cancion, :usuario, :updated_on, :created_on

  def initialize(usuario, cancion, id = nil)
    @usuario = usuario
    @cancion = cancion
    @id = id
    validar_reproduccion!
  end

  def corresponde_a_usuario_y_cancion(usuario, cancion)
    @usuario.id == usuario.id && @cancion.id == cancion.id
  end

  private

  def validar_reproduccion!
    raise UsuarioNoRegistrado if usuario.nil?
    raise ContenidoNoEncontrado if cancion.nil?
  end
end

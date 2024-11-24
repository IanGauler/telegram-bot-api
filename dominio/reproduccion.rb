require_relative './errores/errores_contenido'

class Reproduccion
  attr_accessor :id
  attr_reader :contenido, :usuario, :updated_on, :created_on

  def initialize(usuario, contenido, id = nil)
    @usuario = usuario
    @contenido = contenido
    @id = id
    validar_reproduccion!
  end

  def corresponde_a_contenido(contenido)
    contenido.reproduccion_pertenece_a_contenido(@contenido)
  end

  private

  def validar_reproduccion!
    raise UsuarioNoRegistrado if usuario.nil?
    raise ContenidoNoEncontrado if contenido.nil?
  end
end

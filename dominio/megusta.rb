class MeGusta
  attr_accessor :id
  attr_reader :contenido, :usuario, :updated_on, :created_on

  def initialize(usuario, contenido, id = nil)
    @usuario = usuario
    @contenido = contenido
    @id = id
    validar_me_gusta!
  end

  private

  def validar_me_gusta!
    raise UsuarioNoRegistrado if usuario.nil?
    raise CancionNoEncontrada if contenido.nil?
  end
end

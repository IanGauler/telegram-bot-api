class MeGusta
  attr_accessor :id
  attr_reader :cancion, :usuario, :updated_on, :created_on

  def initialize(usuario, cancion, id = nil)
    @usuario = usuario
    @cancion = cancion
    @id = id
    validar_me_gusta!
  end

  private

  def validar_me_gusta!
    raise UsuarioNoRegistrado if usuario.nil?
    raise CancionNoEncontrada if cancion.nil?
  end
end

class MeGusta
  attr_accessor :id
  attr_reader :cancion, :usuario, :updated_on, :created_on

  def initialize(usuario, cancion, reproduccion, id = nil)
    @usuario = usuario
    @cancion = cancion
    @id = id
    validar_me_gusta!(reproduccion)
  end

  private

  def validar_me_gusta!(reproduccion)
    raise UsuarioNoRegistrado if usuario.nil?
    raise CancionNoEncontrada if cancion.nil?
    raise CancionNoEscuchada if reproduccion.nil? || !reproduccion.corresponde_a_usuario_y_cancion(usuario, cancion)
  end
end

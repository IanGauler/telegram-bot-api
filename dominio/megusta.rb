class MeGusta
  attr_accessor :id
  attr_reader :id_cancion, :id_usuario, :updated_on, :created_on

  def initialize(id_usuario, id_cancion, id = nil)
    @id_usuario = id_usuario
    @id_cancion = id_cancion
    @id = id
  end
end

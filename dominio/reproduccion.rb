class Reproduccion
  attr_accessor :id_cancion, :id_usuario, :upd, :updated_on, :created_on

  def initialize(id_usuario, id_cancion)
    @id_usuario = id_usuario
    @id_cancion = id_cancion
  end
end

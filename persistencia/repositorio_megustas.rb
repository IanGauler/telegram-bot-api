require_relative './abstract_repository'

class RepositorioMegustas < AbstractRepository
  self.table_name = :megustas
  self.model_class = 'MeGusta'

  protected

  def load_object(a_hash)
    MeGusta.new(a_hash[:id_usuario], a_hash[:id_cancion])
  end

  def changeset(reproduccion)
    {
      id_usuario: reproduccion.id_usuario,
      id_cancion: reproduccion.id_cancion
    }
  end
end

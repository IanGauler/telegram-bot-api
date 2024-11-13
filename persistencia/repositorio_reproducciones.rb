require_relative './abstract_repository'

class RepositorioReproducciones < AbstractRepository
  self.table_name = :reproducciones
  self.model_class = 'Reproduccion'

  def existe_reproduccion?(id_usuario, id_cancion)
    reproduccion = dataset.where(id_usuario:, id_cancion:).first

    !reproduccion.nil?
  end

  protected

  def load_object(a_hash)
    Reproduccion.new(a_hash[:id_usuario], a_hash[:id_cancion])
  end

  def changeset(reproduccion)
    {
      id_usuario: reproduccion.id_usuario,
      id_cancion: reproduccion.id_cancion
    }
  end
end

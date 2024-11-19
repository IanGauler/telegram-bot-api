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
    usuario = RepositorioUsuarios.new.find(a_hash[:id_usuario])
    cancion = RepositorioCanciones.new.find(a_hash[:id_cancion])

    Reproduccion.new(usuario, cancion, a_hash[:id])
  end

  def changeset(reproduccion)
    {
      id_usuario: reproduccion.usuario.id,
      id_cancion: reproduccion.cancion.id
    }
  end
end

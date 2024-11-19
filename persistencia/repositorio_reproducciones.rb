require_relative './abstract_repository'

class RepositorioReproducciones < AbstractRepository
  self.table_name = :reproducciones
  self.model_class = 'Reproduccion'

  def obtener_reproduccion(usuario, cancion)
    reproduccion = dataset.where(id_usuario: usuario.id, id_cancion: cancion.id).first
    load_object(reproduccion) unless reproduccion.nil?
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

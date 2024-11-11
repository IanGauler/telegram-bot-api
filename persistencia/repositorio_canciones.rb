require_relative './abstract_repository'

class RepositorioCanciones < AbstractRepository
  self.table_name = :canciones
  self.model_class = 'Cancion'

  protected

  def load_object(a_hash)
    Cancion.new(a_hash[:titulo], a_hash[:artistas], a_hash[:anio], a_hash[:duracion], a_hash[:id])
  end

  def changeset(cancion)
    {
      titulo: cancion.titulo,
      artistas: cancion.artistas,
      anio: cancion.anio,
      duracion: cancion.duracion
    }
  end
end

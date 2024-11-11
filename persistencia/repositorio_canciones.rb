require_relative './abstract_repository'

class RepositorioCanciones < AbstractRepository
  self.table_name = :canciones
  self.model_class = 'Cancion'

  protected

  def load_object(a_hash)
    Cancion.new(a_hash[:titulo], a_hash[:artista], a_hash[:anio], a_hash[:duracion])
  end

  def changeset(cancion)
    {
      titulo: cancion.titulo,
      artista: cancion.artista,
      anio: cancion.anio,
      duracion: cancion.duracion
    }
  end
end

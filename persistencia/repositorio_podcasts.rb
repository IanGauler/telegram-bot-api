require_relative './abstract_repository'

class RepositorioPodcasts < AbstractRepository
  self.table_name = :podcasts
  self.model_class = 'Podcast'

  protected

  def load_object(a_hash)
    Podcast.new(a_hash[:titulo], a_hash[:autor], a_hash[:anio], a_hash[:id])
  end

  def changeset(podcast)
    {
      titulo: podcast.titulo,
      creador: podcast.creador,
      anio: podcast.anio,
      id: podcast.id
    }
  end
end

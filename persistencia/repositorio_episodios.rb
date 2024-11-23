require_relative './abstract_repository'

class RepositorioEpisodios < AbstractRepository
  self.table_name = :episodios
  self.model_class = 'Episodio'

  def save(episodio)
    episodio.id = RepositorioContenido.new.save(TipoContenido.episodio).id if episodio.id.nil?
    super(episodio)
  end

  def obtener_episodios_por_podcast(podcast)
    hash_episodios = dataset.where(id_podcast: podcast.id).all
    cargar_episodios(hash_episodios, podcast)
  end

  private

  def cargar_episodios(hash_episodios, podcast)
    episodios = []
    hash_episodios.each do |hash|
      episodios << Episodio.new(podcast, hash[:titulo], hash[:participantes], hash[:duracion], hash[:id])
    end
    episodios
  end

  protected

  def load_object(a_hash)
    podcast = RepositorioPodcasts.new.find(a_hash[:id_podcast])
    Episodio.new(podcast, a_hash[:titulo], a_hash[:participantes], a_hash[:duracion], a_hash[:id])
  end

  def changeset(episodio)
    {
      id_podcast: episodio.podcast.id,
      titulo: episodio.titulo,
      participantes: episodio.participantes,
      duracion: episodio.duracion,
      id: episodio.id
    }
  end
end

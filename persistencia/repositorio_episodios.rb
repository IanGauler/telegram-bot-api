require_relative './abstract_repository'

class RepositorioEpisodios < AbstractRepository
  self.table_name = :episodios
  self.model_class = 'Episodio'

  def save(episodio)
    episodio.id = RepositorioContenido.new.save(TipoContenido.episodio).id if episodio.id.nil?
    super(episodio)
  end

  def obtener_episodios_por_podcast(id_podcast)
    episodios = []
    all.each do |episodio|
      episodios << episodio if episodio.id_podcast == id_podcast
    end
    episodios
  end

  protected

  def load_object(a_hash)
    Episodio.new(a_hash[:id_podcast], a_hash[:titulo], a_hash[:participantes], a_hash[:duracion], a_hash[:id])
  end

  def changeset(episodio)
    {
      id_podcast: episodio.id_podcast,
      titulo: episodio.titulo,
      participantes: episodio.participantes,
      duracion: episodio.duracion,
      id: episodio.id
    }
  end
end

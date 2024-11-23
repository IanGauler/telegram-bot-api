require_relative './abstract_repository'

class RepositorioPodcasts < AbstractRepository
  self.table_name = :podcasts
  self.model_class = 'Podcast'

  def save(podcast)
    podcast.id = RepositorioContenido.new.save(TipoContenido.podcast).id if podcast.id.nil?
    super(podcast)

    podcast.episodios.each do |episodio|
      RepositorioEpisodios.new.save(episodio)
    end

    podcast
  end

  protected

  def load_object(a_hash)
    podcast = Podcast.new(a_hash[:titulo], a_hash[:creador], a_hash[:anio], a_hash[:id])
    episodios = RepositorioEpisodios.new.obtener_episodios_por_podcast(podcast)

    podcast.agregar_episodios(episodios)
    podcast
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

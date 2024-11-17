require_relative './abstract_repository'

class RepositorioCanciones < AbstractRepository
  self.table_name = :canciones
  self.model_class = 'Cancion'

  def save(cancion)
    cancion.id = RepositorioContenido.new.save(TipoContenido.cancion).id if cancion.id.nil?
    super(cancion)
  end

  def ultimas_canciones(cantidad)
    canciones = dataset.order(Sequel.desc(:id)).limit(cantidad).all
    load_collection(canciones.reverse)
  end

  def obtener_cancion_por_id(id)
    cancion = dataset.where(id:).first

    load_object(cancion) unless cancion.nil?
  end

  def canciones_top_semana(fecha)
    dow_condition = fecha.saturday? || fecha.sunday? ? 'IN (0, 6)' : 'NOT IN (0, 6)'

    query_top_semana(dow_condition).map { |cancion| load_object(cancion) }
  end

  private

  def query_top_semana(dow_condition)
    dataset
      .select_all(:canciones)
      .join(:reproducciones, id_cancion: :id)
      .where(Sequel.lit("EXTRACT(DOW FROM reproducciones.created_on) #{dow_condition}"))
      .group(Sequel[:canciones][:id])
      .order(Sequel.desc(Sequel.function(:COUNT, Sequel[:reproducciones][:id])))
      .limit(5)
  end

  protected

  def load_object(a_hash)
    Cancion.new(a_hash[:titulo], a_hash[:artistas], a_hash[:anio], a_hash[:duracion], a_hash[:id])
  end

  def changeset(cancion)
    {
      titulo: cancion.titulo,
      artistas: cancion.artistas,
      anio: cancion.anio,
      duracion: cancion.duracion,
      id: cancion.id
    }
  end
end

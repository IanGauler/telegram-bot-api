require_relative './abstract_repository'

class RepositorioReproducciones < AbstractRepository
  self.table_name = :reproducciones
  self.model_class = 'Reproduccion'

  def existe_reproduccion?(id_usuario, id_cancion)
    reproduccion = dataset.where(id_usuario:, id_cancion:).first

    !reproduccion.nil?
  end

  def contenido_popular_de_la_semana(fecha)
    dow_condition = fecha.saturday? || fecha.sunday? ? 'NOT IN (0, 6)' : 'IN (0, 6)'

    dataset
      .exclude(Sequel.lit("EXTRACT(DOW FROM created_on) #{dow_condition}"))
      .group_and_count(:id_cancion)
      .order(Sequel.desc(:count))
      .limit(5)
      .map { |row| row[:id_cancion] }
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

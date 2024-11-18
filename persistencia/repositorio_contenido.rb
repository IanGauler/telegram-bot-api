require_relative './abstract_repository'

class RepositorioContenido < AbstractRepository
  self.table_name = :contenidos
  self.model_class = 'TipoContenido'

  protected

  def load_object(a_hash)
    id = a_hash[:id]
    tipo = a_hash[:tipo].to_sym

    case tipo
    when :cancion
      RepositorioCanciones.new.find(id)
    when :podcast
      RepositorioPodcasts.new.find(id)
    end
  end

  def changeset(contenido)
    {
      tipo: contenido.tipo
    }
  end
end

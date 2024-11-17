require_relative './abstract_repository'

class RepositorioContenido < AbstractRepository
  self.table_name = :contenidos
  self.model_class = 'TipoContenido'

  protected

  def load_object(a_hash)
    TipoContenido.para(a_hash[:tipo], a_hash[:id])
  end

  def changeset(contenido)
    {
      tipo: contenido.tipo
    }
  end
end

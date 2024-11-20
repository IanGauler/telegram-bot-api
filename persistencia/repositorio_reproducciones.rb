require_relative './abstract_repository'

class RepositorioReproducciones < AbstractRepository
  self.table_name = :reproducciones
  self.model_class = 'Reproduccion'

  def obtener_reproduccion(usuario, contenido)
    reproduccion = dataset.where(id_usuario: usuario.id, id_contenido: contenido.id).first
    load_object(reproduccion) unless reproduccion.nil?
  end

  protected

  def load_object(a_hash)
    usuario = RepositorioUsuarios.new.find(a_hash[:id_usuario])
    contenido = RepositorioContenido.new.find(a_hash[:id_contenido])

    Reproduccion.new(usuario, contenido, a_hash[:id])
  end

  def changeset(reproduccion)
    {
      id_usuario: reproduccion.usuario.id,
      id_contenido: reproduccion.contenido.id
    }
  end
end

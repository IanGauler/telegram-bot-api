require_relative './abstract_repository'

class RepositorioReproducciones < AbstractRepository
  self.table_name = :reproducciones
  self.model_class = 'Reproduccion'

  def obtener_reproducciones_de_usuario(usuario)
    reproducciones = dataset.where(id_usuario: usuario.id).all

    reproducciones.map do |a_hash|
      contenido = RepositorioContenido.new.find(a_hash[:id_contenido])
      Reproduccion.new(usuario, contenido, a_hash[:id])
    end
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

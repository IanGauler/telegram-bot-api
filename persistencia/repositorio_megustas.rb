require_relative './abstract_repository'

class RepositorioMeGustas < AbstractRepository
  self.table_name = :megustas
  self.model_class = 'MeGusta'

  protected

  def load_object(a_hash)
    usuario = RepositorioUsuarios.new.find(a_hash[:id_usuario])
    contenido = RepositorioContenido.new.find(a_hash[:id_contenido])

    MeGusta.new(usuario, contenido, a_hash[:id])
  end

  def changeset(me_gusta)
    {
      id_usuario: me_gusta.usuario.id,
      id_contenido: me_gusta.contenido.id
    }
  end
end

require_relative './abstract_repository'

class RepositorioMeGustas < AbstractRepository
  self.table_name = :megustas
  self.model_class = 'MeGusta'

  protected

  def load_object(a_hash)
    usuario = RepositorioUsuarios.new.find(a_hash[:id_usuario])
    cancion = RepositorioCanciones.new.find(a_hash[:id_cancion])

    MeGusta.new(usuario, cancion, a_hash[:id])
  end

  def changeset(me_gusta)
    {
      id_usuario: me_gusta.usuario.id,
      id_cancion: me_gusta.cancion.id
    }
  end
end

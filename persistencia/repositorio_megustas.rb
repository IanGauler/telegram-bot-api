require_relative './abstract_repository'

class RepositorioMegustas < AbstractRepository
  self.table_name = :megustas
  self.model_class = 'MeGusta'

  protected

  def load_object(a_hash)
    usuario = RepositorioUsuarios.new.find(a_hash[:id_usuario])
    cancion = RepositorioCanciones.new.find(a_hash[:id_cancion])
    reproduccion = Reproduccion.new(usuario, cancion)
    MeGusta.new(usuario, cancion, reproduccion, a_hash[:id])
  end

  def changeset(reproduccion)
    {
      id_usuario: reproduccion.usuario.id,
      id_cancion: reproduccion.cancion.id
    }
  end
end

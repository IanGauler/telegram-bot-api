require_relative './abstract_repository'

class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  protected

  def load_object(a_hash)
    Usuario.new(a_hash[:id], a_hash[:email])
  end

  def changeset(usuario)
    {
      id: usuario.id,
      email: usuario.email
    }
  end
end

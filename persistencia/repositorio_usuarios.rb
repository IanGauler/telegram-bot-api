require_relative './abstract_repository'

class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  def existe_usuario_con_id?(usuario)
    all.any? { |u| u.id == usuario.id }
  end

  def obtener_usuario_por_id(id)
    usuario = dataset.where(id:).first
    load_object(usuario) unless usuario.nil?
  end

  def obtener_usuario_por_email(email)
    usuario = dataset.where(email:).first
    load_object(usuario) unless usuario.nil?
  end

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

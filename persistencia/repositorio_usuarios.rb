require_relative './abstract_repository'

class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  def existe_usuario_con_id?(usuario)
    all.any? { |u| u.id == usuario.id }
  end

  def existe_usuario_por_email?(usuario)
    all.any? { |u| u.email == usuario.email }
  end

  def obtener_usuario_por_id(id)
    usuario = dataset.where(id:).first
    usuario = load_object(usuario) unless usuario.nil?

    return nil if usuario.nil?

    usuario.reproducciones = RepositorioReproducciones.new.obtener_reproducciones_de_usuario(usuario)
    usuario
  end

  def obtener_usuario_por_email(email)
    usuario = dataset.where(email:).first
    load_object(usuario) unless usuario.nil?
  end

  def save(usuario)
    super(usuario)

    guardar_interacciones(usuario.reproducciones, RepositorioReproducciones.new)
    guardar_interacciones(usuario.me_gustas, RepositorioMeGustas.new)

    usuario
  end

  private

  def guardar_playlist(usuario)
    playlist = usuario.playlist
    playlist.contenidos.each do |contenido|
      Sequel[:playlist].insert(usuario_id: usuario.id, contenido_id: contenido.id)
    end
  end

  def guardar_interacciones(iteracciones, repositorio)
    iteracciones.each do |iteraccion|
      repositorio.save(iteraccion)
    end
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

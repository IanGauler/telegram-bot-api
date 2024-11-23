class Usuario
  attr_reader :email, :updated_on, :created_on
  attr_accessor :id

  def initialize(id, email)
    @email = email
    @id = id
  end

  def esta_registradado?(repositorio_usuarios)
    raise UsuarioYaRegistrado if repositorio_usuarios.existe_usuario_con_id?(self)
    raise MailYaRegistrado if repositorio_usuarios.existe_usuario_por_email?(self)
  end
end

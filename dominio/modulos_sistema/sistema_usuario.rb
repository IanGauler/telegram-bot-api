module SistemaUsuarios
  def usuarios
    @repositorio_usuarios.all
  end

  def crear_usuario(id, email)
    usuario = Usuario.new(id, email)
    raise UsuarioYaRegistrado if @repositorio_usuarios.existe_usuario_con_id?(usuario)
    raise MailYaRegistrado unless @repositorio_usuarios.obtener_usuario_por_email(email).nil?

    @repositorio_usuarios.save(usuario)
    usuario
  end
end

class ErrorUsuario < StandardError
end

class UsuarioYaRegistrado < ErrorUsuario
  def initialize(msg = 'Usuario ya registrado')
    super(msg)
  end
end

class MailYaRegistrado < ErrorUsuario
  def initialize(msg = 'Mail ya registrado')
    super(msg)
  end
end

class UsuarioNoRegistrado < ErrorUsuario
  def initialize(msg = 'El usuario no fue encontrado.')
    super(msg)
  end
end

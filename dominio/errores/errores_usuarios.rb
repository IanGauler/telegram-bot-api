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

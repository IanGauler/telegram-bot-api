class Usuario
  attr_reader :email, :updated_on, :created_on
  attr_accessor :id, :reproducciones, :me_gustas

  def initialize(id, email)
    @email = email
    @id = id
    @reproducciones = []
    @me_gustas = []
  end

  def esta_registradado?(repositorio_usuarios)
    raise UsuarioYaRegistrado if repositorio_usuarios.existe_usuario_con_id?(self)
    raise MailYaRegistrado if repositorio_usuarios.existe_usuario_por_email?(self)
  end

  def reproducir(contenido)
    @reproducciones << Reproduccion.new(self, contenido)
  end

  def dar_megusta_a(cancion)
    raise CancionNoEncontrada if cancion.nil?
    raise ContenidoNoEscuchado unless @reproducciones.any? { |r| r.corresponde_a_contenido(cancion) }

    @me_gustas << MeGusta.new(self, cancion)
  end
end

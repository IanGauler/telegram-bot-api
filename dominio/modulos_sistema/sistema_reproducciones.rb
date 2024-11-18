module SistemaReproducciones
  def reproducciones
    @repositorio_reproducciones.all
  end

  def registrar_reproduccion(email, id_cancion)
    usuario = @repositorio_usuarios.obtener_usuario_por_email(email)
    raise UsuarioNoRegistrado if usuario.nil?

    cancion = @administrador_de_contenido.repositorio_canciones.obtener_cancion_por_id(id_cancion)
    raise ContenidoNoEncontrado if cancion.nil?

    reproduccion = Reproduccion.new(usuario.id, id_cancion)
    @repositorio_reproducciones.save(reproduccion)
  end
end

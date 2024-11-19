module SistemaReproducciones
  def reproducciones
    @repositorio_reproducciones.all
  end

  def registrar_reproduccion(email, id_cancion)
    usuario = @repositorio_usuarios.obtener_usuario_por_email(email)
    cancion = @administrador_de_contenido.repositorio_canciones.obtener_cancion_por_id(id_cancion)

    reproduccion = Reproduccion.new(usuario, cancion)
    @repositorio_reproducciones.save(reproduccion)
  end
end

module SistemaMeGusta
  def megustas
    @repositorio_megustas.all
  end

  def registrar_megusta(id_usuario, id_cancion)
    cancion = @administrador_de_contenido.repositorio_canciones.obtener_cancion_por_id(id_cancion)
    usuario = @repositorio_usuarios.obtener_usuario_por_id(id_usuario)
    raise CancionNoEncontrada if cancion.nil?
    raise UsuarioNoRegistrado if usuario.nil?

    reproduccion = @repositorio_reproducciones.obtener_reproduccion(usuario, cancion)
    megusta = MeGusta.new(usuario, cancion, reproduccion)
    @repositorio_megustas.save(megusta)
  end
end

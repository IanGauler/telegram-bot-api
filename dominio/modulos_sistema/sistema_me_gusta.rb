module SistemaMeGusta
  def megustas
    @repositorio_megustas.all
  end

  def registrar_megusta(id_usuario, id_cancion)
    cancion = @administrador_de_contenido.repositorio_canciones.obtener_cancion_por_id(id_cancion)
    raise CancionNoEncontrada if cancion.nil?
    raise CancionNoEscuchada unless @repositorio_reproducciones.existe_reproduccion?(id_usuario, id_cancion)

    megusta = MeGusta.new(id_usuario, id_cancion)
    @repositorio_megustas.save(megusta)
  end
end

class CancionNoEncontrada < ErrorCancion
  def initialize(msg = 'La canción no fue encontrada.')
    super(msg)
  end
end

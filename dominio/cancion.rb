class Cancion
  attr_reader :titulo, :artistas, :anio, :duracion, :updated_on, :created_on
  attr_accessor :id

  FORMATO_DURACION = /\A[1-9]\d*:[0-5]\d\z/
  FORMATO_ANIO_VALIDO = /\A\d+\z/

  def initialize(titulo, artistas, anio, duracion, id = nil)
    @titulo = titulo
    @artistas = artistas
    @anio = validar_anio(anio)
    @duracion = duracion
    @id = id
    validar!
  end

  def representacion_hash
    hash = { titulo: @titulo, artistas: @artistas, anio: @anio, duracion: @duracion }
    hash[:id] = @id unless @id.nil?
    hash
  end

  def reproduccion_pertenece_a_contenido(contenido)
    @id == contenido.id
  end

  def artistas_participantes
    @artistas.split(',').map(&:strip)
  end

  private

  def validar!
    validar_titulo
    validar_artistas
    validar_duracion
    validar_formato_duracion
  end

  def validar_titulo
    raise TituloVacio if titulo.empty?
  end

  def validar_artistas
    raise ArtistasVacios if artistas.empty?
  end

  def validar_duracion
    raise DuracionVacia if duracion.empty?
  end

  def validar_anio(anio)
    raise AnioVacio if anio.is_a?(String) && anio.empty?
    raise AnioInvalido if anio.is_a?(String) && !anio.match?(FORMATO_ANIO_VALIDO)
    raise AnioFueraDeRango if anio.to_i > Time.now.year

    anio.to_i
  end

  def validar_formato_duracion
    raise FormatoInvalidoDuracion unless duracion.match?(FORMATO_DURACION)
  end
end

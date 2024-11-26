class Episodio
  attr_reader :titulo, :participantes, :duracion, :podcast, :updated_on, :created_on
  attr_accessor :id

  def initialize(podcast, titulo, participantes, duracion, id = nil)
    @titulo = titulo
    @participantes = participantes
    @duracion = duracion
    @podcast = podcast
    @id = id
    validar
  end

  def representacion_hash
    hash = { titulo: @titulo, participantes: @participantes, duracion: @duracion }
    hash[:id] = @id unless @id.nil?
    hash
  end

  def reproduccion_pertenece_a_contenido(_contenido)
    raise NoSePuedeDarMeGustaAEpisodios
  end

  private

  def validar
    validar_titulo
    validar_participantes
    validar_duracion
  end

  def validar_titulo
    raise TituloVacioEpisodio if @titulo.empty?
  end

  def validar_participantes
    raise ParticipantesVacioEpisodio if @participantes.empty?
  end

  def validar_duracion
    raise FormatoInvalidoDuracionEpisodio unless @duracion.is_a?(String)
    raise DuracionVaciaEpisodio if @duracion.empty?
    raise FormatoInvalidoDuracionEpisodio unless @duracion.match?(/\A\d+:(?:[0-5]\d)\z/)
  end
end

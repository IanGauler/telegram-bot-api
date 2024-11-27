require_relative 'validacion_contenido_helper'
class Episodio
  attr_accessor :podcast, :id
  attr_reader :titulo, :participantes, :duracion, :updated_on, :created_on

  def initialize(titulo, participantes, duracion, id = nil, podcast = nil)
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
    validar_contenido(@titulo, TituloVacioEpisodio, ErrorEpisodioInvalido)
    validar_participantes
    validar_duracion
  end

  def validar_participantes
    raise ErrorEpisodioInvalido unless @participantes.is_a?(String)
    raise ParticipantesVacioEpisodio if @participantes.empty?
  end

  def validar_duracion
    validar_formato_duracion(@duracion, FormatoInvalidoDuracionEpisodio, DuracionVaciaEpisodio, ErrorEpisodioInvalido)
  end
end

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
    validar_titulo
    validar_participantes
    validar_duracion
  end

  def validar_titulo
    validar_parametro(@titulo, TituloVacioEpisodio)
  end

  def validar_participantes
    validar_parametro(@participantes, ParticipantesVacioEpisodio)
  end

  def validar_duracion
    validar_formato_duracion(@duracion, FormatoInvalidoDuracionEpisodio, DuracionVaciaEpisodio, ErrorEpisodioInvalido)
  end

  def validar_parametro(parametro, error_parametro_vacio)
    raise ErrorEpisodioInvalido unless parametro.is_a?(String)
    raise error_parametro_vacio if parametro.empty?
  end
end

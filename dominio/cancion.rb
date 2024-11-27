require_relative 'validacion_contenido_helper'
class Cancion
  attr_reader :titulo, :artistas, :anio, :duracion, :updated_on, :created_on
  attr_accessor :id

  def initialize(titulo, artistas, anio, duracion, id = nil)
    @titulo = titulo
    @artistas = artistas
    @anio = validar_anio(anio, ErrorCancionInvalida)
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
    validar_parametro(@titulo, TituloVacio, ErrorCancionInvalida)
    validar_artistas
    validar_formato_duracion(duracion, FormatoInvalidoDuracion, DuracionVacia, ErrorCancionInvalida)
  end

  def validar_artistas
    raise ArtistasVacios if artistas.empty?
  end
end

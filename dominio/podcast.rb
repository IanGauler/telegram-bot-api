require_relative 'validacion_contenido_helper'
class Podcast
  attr_reader :titulo, :creador, :anio, :updated_on, :created_on, :episodios
  attr_accessor :id

  def initialize(titulo, creador, anio, episodios, id = nil)
    @titulo = titulo
    @creador = creador
    @anio = validar_anio(anio)
    @id = id
    @episodios = inicializar_episodios(episodios)
    validar!
  end

  def agregar_episodios(episodios)
    sumar_episodios(episodios)
  end

  def representacion_hash
    hash = { titulo: @titulo, creador: @creador, anio: @anio, id: @id }
    hash[:episodios] = @episodios.map(&:representacion_hash) if @episodios.any?
    hash
  end

  def tiene_episodio(episodio)
    raise EpisodioNoPerteneceAPodcast unless @episodios.any? { |e| e.id == episodio.id }
  end

  def reproduccion_pertenece_a_contenido(contenido)
    @episodios.any? { |episodio| episodio.id == contenido.id }
  end

  private

  def inicializar_episodios(episodios)
    nuevos_episodios = []
    sumar_episodios(episodios, nuevos_episodios)
    nuevos_episodios
  end

  def sumar_episodios(episodios, nuevos_episodios = @episodios)
    if episodios.is_a?(Array)
      episodios.each do |episodio|
        agregar_episodio(episodio, nuevos_episodios)
      end
    else
      agregar_episodio(episodios, nuevos_episodios)
    end
  end

  def agregar_episodio(episodio, nuevos_episodios = @episodios)
    episodio.podcast = self
    nuevos_episodios << episodio
  end

  def validar!
    validar_contenido(@titulo, TituloVacio, ErrorPodcastInvalido)
    raise CreadorVacio if creador.empty?
    raise EpisodiosVacios if episodios.empty?
  end
end

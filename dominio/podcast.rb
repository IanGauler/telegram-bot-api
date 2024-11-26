class Podcast
  attr_reader :titulo, :creador, :anio, :updated_on, :created_on, :episodios
  attr_accessor :id

  def initialize(titulo, creador, anio, id = nil)
    @titulo = titulo
    @creador = creador
    @anio = anio
    @id = id
    @episodios = []
    validar!
  end

  def agregar_episodios(episodios)
    if episodios.is_a?(Array)
      episodios.each do |episodio|
        agregar_episodio(episodio)
      end
    else
      agregar_episodio(episodios)
    end
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

  def agregar_episodio(episodio)
    @episodios << episodio
  end

  def validar!
    raise TituloVacio if titulo.empty?
    raise CreadorVacio if creador.empty?
  end
end

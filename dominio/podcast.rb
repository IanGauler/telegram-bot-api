class Podcast
  attr_reader :titulo, :creador, :anio, :updated_on, :created_on, :episodios
  attr_accessor :id

  def initialize(titulo, creador, anio, id = nil)
    @titulo = titulo
    @creador = creador
    @anio = anio
    @id = id
    @episodios = []
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
    hash = { titulo: @titulo, autor: @creador, anio: @anio, id: @id }
    hash[:episodios] = @episodios.map(&:representacion_hash) if @episodios.any?
    hash
  end

  private

  def agregar_episodio(episodio)
    @episodios << episodio
  end
end

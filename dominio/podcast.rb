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

  def agregar_episodio(episodio)
    @episodios << episodio
  end
end

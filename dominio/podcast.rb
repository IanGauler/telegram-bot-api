class Podcast
  attr_reader :titulo, :creador, :anio, :updated_on, :created_on
  attr_accessor :id

  def initialize(titulo, creador, anio, id)
    @titulo = titulo
    @creador = creador
    @anio = anio
    @id = id
  end
end

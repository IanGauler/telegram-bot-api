class Cancion
  attr_reader :titulo, :artistas, :anio, :duracion, :updated_on, :created_on
  attr_accessor :id

  def initialize(titulo, artistas, anio, duracion, id = nil)
    @titulo = titulo
    @artistas = artistas
    @anio = anio
    @duracion = duracion
    @id = id
  end
end

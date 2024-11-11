class Cancion
  attr_reader :titulo, :artistas, :anio, :duracion, :updated_on, :created_on
  attr_accessor :id

  def initialize(titulo, artistas, anio, duracion)
    @titulo = titulo
    @artistas = artistas
    @anio = anio
    @duracion = duracion
  end
end

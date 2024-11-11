class Cancion
  attr_reader :titulo, :artista, :anio, :duracion, :updated_on, :created_on
  attr_accessor :id

  def initialize(titulo, artista, anio, duracion)
    @titulo = titulo
    @artista = artista
    @anio = anio
    @duracion = duracion
  end
end

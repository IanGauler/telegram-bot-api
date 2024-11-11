class Cancion
  attr_reader :nombre, :artista, :anio, :duracion

  def initialize(nombre, artista, anio, duracion)
    @nombre = nombre
    @artista = artista
    @anio = anio
    @duracion = duracion
  end
end

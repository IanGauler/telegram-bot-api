class Episodio
  attr_reader :titulo, :participantes, :duracion, :updated_on, :created_on
  attr_accessor :id

  def initialize(id, titulo, participantes, duracion)
    @titulo = titulo
    @participantes = participantes
    @duracion = duracion
    @id = id
  end
end

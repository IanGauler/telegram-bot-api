class Episodio
  attr_reader :titulo, :participantes, :duracion, :id_podcast, :updated_on, :created_on
  attr_accessor :id

  def initialize(id_podcast, titulo, participantes, duracion, id = nil)
    @titulo = titulo
    @participantes = participantes
    @duracion = duracion
    @id_podcast = id_podcast
    @id = id
  end
end

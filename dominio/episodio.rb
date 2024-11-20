class Episodio
  attr_reader :titulo, :participantes, :duracion, :podcast, :updated_on, :created_on
  attr_accessor :id

  def initialize(podcast, titulo, participantes, duracion, id = nil)
    @titulo = titulo
    @participantes = participantes
    @duracion = duracion
    @podcast = podcast
    @id = id
  end

  def representacion_hash
    hash = { titulo: @titulo, participantes: @participantes, duracion: @duracion }
    hash[:id] = @id unless @id.nil?
    hash
  end

  def pertenece_a_podcast(podcast)
    raise EpisodioNoPerteneceAPodcast unless @podcast.id == podcast.id
  end
end

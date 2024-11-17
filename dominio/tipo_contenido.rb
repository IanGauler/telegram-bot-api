class TipoContenido
  attr_reader :updated_on, :created_on, :tipo
  attr_accessor :id

  CANCION = 'cancion'.freeze
  PODCAST = 'podcast'.freeze
  EPISODIO = 'episodio'.freeze

  def self.cancion(id = nil)
    new(CANCION, id)
  end

  def self.podcast(id = nil)
    new(PODCAST, id)
  end

  def self.episodio(id = nil)
    new(EPISODIO, id)
  end

  def self.para(tipo, id = nil)
    case tipo
    when CANCION
      cancion(id)
    when PODCAST
      podcast(id)
    when EPISODIO
      episodio(id)
    end
  end

  def initialize(tipo, id = nil)
    @id = id
    @tipo = tipo
  end
end

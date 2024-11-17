class TipoContenido
  attr_reader :updated_on, :created_on, :tipo
  attr_accessor :id

  CANCION = 'cancion'.freeze
  PODCAST = 'podcast'.freeze
  EPISODIO = 'episodio'.freeze

  def self.cancion
    new(CANCION)
  end

  def self.podcast
    new(PODCAST)
  end

  def self.episodio
    new(EPISODIO)
  end

  def self.para(tipo)
    case tipo
    when CANCION
      cancion
    when PODCAST
      podcast
    when EPISODIO
      episodio
    end
  end

  def initialize(tipo, id = nil)
    @id = id
    @tipo = tipo
  end
end

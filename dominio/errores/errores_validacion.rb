class TituloVacio < StandardError
  def initialize(msg = 'El titulo no puede ser vacio')
    super(msg)
  end
end

class CreadorVacio < StandardError
  def initialize(msg = 'El creador no puede ser vacio')
    super(msg)
  end
end

class AnioVacio < StandardError
  def initialize(msg = 'El año no puede ser vacio')
    super(msg)
  end
end

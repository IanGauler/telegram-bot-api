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

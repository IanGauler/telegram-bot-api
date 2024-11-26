class ErrorConector < StandardError
end

class RecomendacionesNoDisponibles < ErrorConector
  def initialize(msg = 'Nuestro proveedor de recomendaciones no se encuentra disponible en este momento.')
    super(msg)
  end
end

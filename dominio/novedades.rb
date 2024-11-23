class Novedades
  def initialize(cantidad)
    @cantidad = cantidad
  end

  def listar(repositorio_contenido)
    repositorio_contenido.ultimos_contenidos(@cantidad)
  end
end

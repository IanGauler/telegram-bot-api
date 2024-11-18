class Novedades
  def initialize(cantidad)
    @cantidad = cantidad
  end

  def listar(repositorio_contenido)
    repositorio_contenido.ultimas_novedades(@cantidad)
  end
end

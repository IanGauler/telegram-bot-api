class AdministradorDeContenido
  attr_reader :repositorio_contenidos, :repositorio_canciones, :repositorio_podcasts, :repositorio_episodios

  def initialize(repositorio_contenidos, repositorio_canciones, repositorio_podcasts = nil, repositorio_episodios = nil)
    @repositorio_contenidos = repositorio_contenidos
    @repositorio_canciones = repositorio_canciones
    @repositorio_podcasts = repositorio_podcasts
    @repositorio_episodios = repositorio_episodios
  end

  def resetear
    @repositorio_contenidos.delete_all
  end
end

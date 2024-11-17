class AdministradorDeContenido
  attr_reader :repositorio_contenidos, :repositorio_canciones, :repositorio_podcasts, :repositorio_episodios, :fabrica_de_contenidos

  def initialize(repositorio_contenidos, repositorio_canciones, repositorio_podcasts = nil, repositorio_episodios = nil, fabrica_de_contenidos = nil)
    @repositorio_contenidos = repositorio_contenidos
    @repositorio_canciones = repositorio_canciones
    @repositorio_podcasts = repositorio_podcasts
    @repositorio_episodios = repositorio_episodios
    @fabrica_de_contenidos = fabrica_de_contenidos
  end

  def resetear
    @repositorio_canciones.delete_all
  end
end

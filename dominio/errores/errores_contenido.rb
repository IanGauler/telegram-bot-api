class ErrorContenido < StandardError
end

class ContenidoNoEncontrado < ErrorContenido
  def initialize(msg = 'El contenido no fue encontrado.')
    super(msg)
  end
end

class ContenidoNoEscuchado < ErrorContenido
  def initialize(msg = 'Aún no has escuchado este contenido.')
    super(msg)
  end
end

class NoSePuedeDarMeGustaAEpisodios < ErrorContenido
  def initialize(msg = 'No se puede dar me gusta a episodios.')
    super(msg)
  end
end

class EpisodioNoPerteneceAPodcast < ErrorContenido
  def initialize(msg = 'El episodio no pertenece al podcast.')
    super(msg)
  end
end

class AgregarPodcastAPlaylist < ErrorContenido
  def initialize(msg = 'No se puede agregar un podcast a la playlist.')
    super(msg)
  end
end

class ContenidoDuplicadoPlaylist < ErrorContenido
  def initialize(msg = 'Este contenido ya se encuentra en tu playlist.')
    super(msg)
  end
end

class ErrorEpisodioInvalido < ErrorContenido
end

class TituloVacioEpisodio < ErrorEpisodioInvalido
  def initialize(msg = 'Episodio inválido: El título no puede ser vacío')
    super(msg)
  end
end

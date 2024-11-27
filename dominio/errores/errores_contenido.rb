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
  def initialize(msg = 'Episodio inválido.')
    super(msg)
  end
end

class TituloVacioEpisodio < ErrorEpisodioInvalido
  def initialize(msg = 'Episodio inválido: El título no puede ser vacío')
    super(msg)
  end
end

class ParticipantesVacioEpisodio < ErrorEpisodioInvalido
  def initialize(msg = 'Episodio inválido: Los participantes no puede ser vacío')
    super(msg)
  end
end

class DuracionVaciaEpisodio < ErrorEpisodioInvalido
  def initialize(msg = 'Episodio inválido: La duración no puede ser vacía')
    super(msg)
  end
end

class FormatoInvalidoDuracion < StandardError
  def initialize(msg = 'Formato de duración inválido. Debe ser MM:SS')
    super(msg)
  end
end

class FormatoInvalidoDuracionEpisodio < ErrorEpisodioInvalido
  def initialize(msg = 'Episodio inválido: Formato de duración inválido. Debe ser MM:SS')
    super(msg)
  end
end

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

class AnioInvalido < StandardError
  def initialize(msg = 'Formato de año inválido. Debe ser un número menor al año actual')
    super(msg)
  end
end

class AnioFueraDeRango < StandardError
  def initialize(msg = 'Formato de año inválido. Debe ser un número menor al año actual')
    super(msg)
  end
end

class EpisodiosVacios < StandardError
  def initialize(msg = 'Debe contener al menos 1 episodio')
    super(msg)
  end
end

class ArtistasVacios < StandardError
  def initialize(msg = 'Los artistas no pueden ser vacio')
    super(msg)
  end
end

class DuracionVacia < StandardError
  def initialize(msg = 'La duración no puede ser vacía')
    super(msg)
  end
end

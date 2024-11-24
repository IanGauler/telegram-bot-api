class Playlist
  attr_reader :contenido

  def initialize
    @contenidos = []
  end

  def agregar_contenido(contenido)
    validar_contenido(contenido)
    @contenidos << contenido
  end

  private

  def validar_contenido(contenido)
    contenido_no_encontrado?(contenido)
    contenido_es_podcast?(contenido)
    contenido_duplicado?(contenido)
  end

  def contenido_duplicado?(contenido)
    raise ContenidoDuplicadoPlaylist if @contenidos.any? { |c| c.id = contenido.id }
  end

  def contenido_es_podcast?(contenido)
    raise AgregarPodcastAPlaylist if contenido.is_a?(Podcast)
  end

  def contenido_no_encontrado?(contenido)
    raise ContenidoNoEncontrado if contenido.nil?
  end
end

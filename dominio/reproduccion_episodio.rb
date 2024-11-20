class ReproduccionEpisodio
  attr_reader :email, :id_episodio, :id_podcast

  def initialize(email, id_episodio, id_podcast)
    @email = email
    @id_episodio = id_episodio
    @id_podcast = id_podcast
  end
end

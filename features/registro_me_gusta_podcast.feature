# language: es
Característica:
  Como usuario
  quiero indicar que me gusta un podcast
  para que el bot me recomiende contenido similar en el futuro

  Antecedentes:
    Dado que mi usuario es "juan" con id "1" y mail "juan@gmail.com", y estoy registrado
    Y que existe el podcast "Caja Negra" con el episodio "Ep1"

  Escenario: US24-01 Dar me gusta a un podcast reproducido
    Dado que he reproducido el episodio "Ep1"
    Cuando envio el comando "/megusta" con el id de "Caja Negra"
    Entonces el bot muestra el mensaje "Calificacion registrada"

  Escenario: US24-02 Dar me gusta a un podcast no escuchado
    Cuando envio el comando "/megusta" con el id de "Caja Negra"
    Entonces el bot muestra el mensaje "Aún no has escuchado este contenido."

  Escenario: US24-03 Dar me gusta a un contenido inexistente
    Cuando envio el comando "/megusta" con el id de "Podcast Inexistente"
    Entonces el bot muestra el mensaje "El contenido no fue encontrado."
  @wip
  Escenario: US24-04 Dar me gusta a un episodio
    Cuando envio el comando "/megusta" con el id de "Ep1"
    Entonces el bot muestra el mensaje "No se puede dar me gusta a episodios. Podes darle me gusta al podcast."

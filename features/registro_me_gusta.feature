# language: es
Característica:
  Como usuario
  quiero indicar que me gusta una cancion
  para que el bot me recomiende contenido similar en el futuro

Antecedentes:
  Dado que mi usuario es "juan" con id "1" y mail "juan@gmail.com", y estoy registrado
  Y que existe la cancion "Waka Waka"

@wip @current
Escenario: US7-01 Dar me gusta a una cancion escuchada
  Dado que he reproducido la cancion "Waka Waka"
  Cuando envio el comando "/megusta" con la id de "Waka Waka"
  Entonces el bot muestra el mensaje "Calificacion registrada"

@wip
Escenario: US7-02 Dar me gusta a una cancion no escuchada
  Cuando envio el comando "/megusta" con la id de "Waka Waka"
  Entonces el bot muestra el mensaje "Aún no has escuchado esta cancion."

Escenario: US7-03 Dar me gusta a una cancion inexistente
  Cuando envio el comando "/megusta" con la id de "Cancion Inexistente"
  Entonces el bot muestra el mensaje "La cancion no existe."

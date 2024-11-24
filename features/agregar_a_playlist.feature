# language: es
Característica:
	Como usuario  
	quiero agregar contenido a mi playlist  
	para guardar el contenido que más me gustan en una lista independiente de los me gusta

	Antecedentes:
	  Dado que mi usuario es "juan" con id "1235" y mail "juan@gmail.com", y estoy registrado
	  Y que existe el podcast "Caja Negra" con el episodio "Ep1"
	  Y que existe la cancion "That's so true"
	  Y que mi playlist esta vacia

  Escenario: US14-01 - Agregar una canción a la playlist
	  Cuando intento agregar a la playlist "That's so true"
	  Entonces el "That's so true" se agrega a mi playlist
	
	@wip
  Escenario: US14-02 - Agregar un episodio a la playlist
	  Cuando intento agregar a la playlist "Ep1"
	  Entonces el bot muestra el mensaje "\"Ep1\" agregado a tu playlist."
	
  Escenario: US14-03 - El ID de contenido no existe
	  Cuando envio el comando "/agregar_a_playlist" con id inexistente
	  Entonces el bot muestra el mensaje "El contenido no fue encontrado."
	
  Escenario: US14-04 - Intentar agregar un podcast completo a la playlist
	  Cuando intento agregar a la playlist "Caja Negra"
	  Entonces el bot muestra el mensaje "No se puede agregar podcast a una playlist. Deberías agregar los episodios individualmente."
	
  @wip
  Escenario: US14-05 - Intentar agregar un contenido duplicado a la playlist
	  Cuando intento agregar a la playlist "Ep1"
	  Y intento agregar a la playlist "Ep1" 
	  Entonces el bot muestra el mensaje "Este contenido ya se encuentra en tu playlist."

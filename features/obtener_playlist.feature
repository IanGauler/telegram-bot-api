# language: es
Característica:
	Como usuario  
	quiero consultar el contenido de mi playlist  
	para saber el contenido disponible en mi playlist

	Antecedentes:
		Dado que mi usuario es "juan" con id "1235" y mail "juan@gmail.com", y estoy registrado
		Y que existe el podcast "Caja Negra" con el episodio "Ep1"
		Y que existe la cancion "That's so true"

	Escenario: US23-01 - Ver contenido de playlist
		Dado que agregue a mi playlist "That's so true"
		Y que agregue a mi playlist "Ep1"
		Cuando envio el comando "/playlist"
		Entonces el bot muestra el mensaje
			"""
			That's so true (<id>)
			Ep1 (<id>)
			"""

	Escenario: US23-02 - Ver contenido de playlist vacia
		Dado que mi playlist esta vacia
		Cuando envio el comando "/playlist"
		Entonces no obtengo contenidos de mi playlist

# language: es
Característica: 
  Como usuario 
  quiero consultar detalles de un podcast
  para tener mas informacion del mismo

  Antecedentes:
    Dado que mi usuario es "juan" con id "1" y mail "juan@gmail.com", y estoy registrado
    Y que existe el podcast "Caja Negra" con "2" episodios

  Escenario: US12-1 Consulta de detalles de un podcast existente
    Cuando consulto los detalles de "Caja Negra"
    Entonces el bot muestra los detalles del podcast
      """
      Titulo: Caja Negra
      Creador: Filo.news
      Año: 2020
      Episodios:
          <id_episodio1>: '<Titulo episodio 1>' - <Duracion episodio 1>
          <id_episodio2>: '<Titulo episodio 2>' - <Duracion episodio 2>
      """

  Escenario: US12-2 Consulta de un podcast inexistente
    Cuando consulto los detalles del contenido inexistente
    Entonces el bot muestra el mensaje "El contenido no fue encontrado."

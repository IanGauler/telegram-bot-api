# language: es
Característica: 
  Como usuario 
  quiero recibir novedades de podcasts y canciones
  para descubrir nuevos podcasts y canciones

  Antecedentes:
    Dado que mi usuario es "juan" con id "1" y mail "juan@gmail.com", y estoy registrado

    Escenario: US10-01 Recomendaciones de canciones y podcasts cuando no hay contenido
      Dado que no hay contenido en el sistema
      Cuando envío el comando "/novedades"
      Entonces el bot muestra el mensaje "No se ha podido encontrar contenido"

    Escenario: US10-02 Recomenadaciones de canciones y podcasts
      Dado que existe la canción "wakawaka"
      Y que existe el podcast "wanshow" con "1" episodios
      Cuando envío el comando "/novedades"
      Entonces me recomienda "wakawaka"
      Y me recomienda "wanshow"

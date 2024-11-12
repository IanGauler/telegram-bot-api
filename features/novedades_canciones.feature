      # language: es
      Característica:
      Como usuario
      quiero recibir novedades de canciones
      para descubrir nuevas canciones

      Contexto:
      Dado que mi usuario es "juan" con id "1" y mail "juan@gmail.com", y estoy registrado

      Escenario: US4-01 Recibir recomendaciones de novedades cuando hay exactamente 5 canciones en la plataforma
      Dado que en la plataforma existen "Bohemian Rhapsody", "Billie Jean", "Imagine", "Shape of You", "Rolling in the Deep"
      Cuando envío el comando "/novedades"
      Entonces el bot muestra "5" canciones
      """
      Canción: Bohemian Rhapsody (1)
      Canción: Billie Jean (2)
      Canción: Imagine (3)
      Canción: Shape of You (4)
      Canción: Rolling in the Deep (5)
      """

      Escenario: US4-02 Recibir recomendaciones de novedades cuando hay menos de 5 canciones en la plataforma
      Dado que en la plataforma existen "Bohemian Rhapsody", "Billie Jean", "Imagine"
      Cuando envío el comando "/novedades"
      Entonces el bot muestra "3" canciones
      """
      Canción: Bohemian Rhapsody (1)
      Canción: Billie Jean (2)
      Canción: Imagine (3)
      """

Escenario: US4-03 Recibir recomendaciones de novedades cuando no hay canciones
Dado que en la plataforma no hay canciones
Cuando envío el comando "/novedades"
Entonces el bot muestra el mensaje "No se han podido encontrar canciones".
@wip
Escenario: US4-04 Recibir recomendaciones de novedades cuando hay más de 5 canciones en la plataforma
Dado que en la plataforma existen "7" canciones
Cuando envío el comando "/novedades"
Entonces el bot muestra las ultimas "5" canciones agregadas

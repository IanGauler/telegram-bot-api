# language: es

Característica:

Como usuario
quiero obtener recomendaciones según mi artista más escuchado
para poder encontrar artistas similares

Antecedentes:
Dado que existe una canción de "Metallica" en la plataforma
Y que existe una canción de "Taylor Swift" en la plataforma
Y que mi usuario es "juan" con id "1" y mail "juan@gmail.com", y estoy registrado
Y que tengo acceso a Spotify

Escenario: US22-01 No hay recomendaciones
Cuando busco artistas recomendados
Entonces el bot muestra el mensaje "No se pudo obtener artistas recomendados"

Escenario: US22-02 Artistas relacionados al que escuché
Dado que escuché "1" veces a "Metallica"
Cuando busco artistas recomendados
Entonces me recomiendan "5" artistas parecidos a "Metallica"

Escenario: US22-03 Artistas relacionados al más escuchado
Dado que escuché "1" veces a "Metallica"
Y que escuché "2" veces a "Taylor Swift"
Cuando busco artistas recomendados
Entonces me recomiendan "5" artistas parecidos a "Taylor Swift"

@wip
Escenario: US22-04 Spotify caído
Dado que no tengo acceso a Spotify
Y que escuché "1" canciones de "Metallica"
Cuando busco artistas recomendados
Entonces el bot muestra el mensaje "No se pudo obtener artistas recomendados"

Escenario: US22-05 No se recomienda por podcast
Dado que existe el podcast "Caja Negra" con el episodio "Ep1"
Y que he reproducido el episodio "Ep1"
Cuando busco artistas recomendados
Entonces el bot muestra el mensaje "No se pudo obtener artistas recomendados"

# language: es
Característica:
Como miembro del equipo de desarrollo
quiero una API que me permita dar de alta canciones nuevas en la plataforma
para tener siempre disponible el catalogo de canciones actualizado en el bot

Antecedentes:
Dado que no hay canciones en la plataforma

Escenario: US3-01 Dar de alta una cancion en la plataforma
Dado que quiero cargar la cancion "Waka-Waka" del artista "Shakira" lanzada en el año "2010" y con una duracion "3:31"
Cuando publico en la API con "/agregar_canciones" esas canciones
Entonces la cancion "Waka-Waka" es dada de alta

Escenario: US3-02 Dar de alta dos canciones en la plataforma
Dado que quiero cargar la cancion "Waka-Waka" del artista "Shakira" lanzada en el año "2010" y con una duracion "3:31"
Y que quiero cargar la cancion "Paper Rings" del artista "Taylor Swift" lanzada en el año "2019" y con una duracion "3:44"
Cuando publico en la API con "/agregar_canciones" esas canciones
Entonces la cancion "Paper Rings" es dada de alta
Y la cancion "Waka-Waka" es dada de alta

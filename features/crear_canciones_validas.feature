# language: es

Característica:

  Como miembro del equipo de desarrollo
  quiero una API que me permita dar de alta canciones validas en la plataforma
  para tener siempre disponible el catálogo de canciones actualizado en el bot.

  Antecedentes:
    Dado que el anio actual es "2024"

  Escenario: US18-01 Título vacío
    Dado que la cancion tiene "titulo" vacio
    Y que la cancion tiene por "artistas": "Toto"
    Y que la cancion tiene por "duracion": "4:31"
    Y que la cancion tiene por "anio": "2013"
    Cuando publico en la API con "/canciones" el contenido
    Entonces obtengo el error "El titulo no puede ser vacio"

  Escenario: US18-02 Artistas vacío
    Dado que la cancion tiene por "titulo": "Africa"
    Y que la cancion tiene "artistas" vacio
    Y que la cancion tiene por "duracion": "4:31"
    Y que la cancion tiene por "anio": "2013"
    Cuando publico en la API con "/canciones" el contenido
    Entonces obtengo el error "Los artistas no pueden ser vacio"

  Escenario: US18-03 Duración vacía
    Dado que la cancion tiene por "titulo": "Africa"
    Y que la cancion tiene por "artistas": "Toto"
    Y que la cancion tiene "duracion" vacio
    Y que la cancion tiene por "anio": "2013"
    Cuando publico en la API con "/canciones" el contenido
    Entonces obtengo el error "La duración no puede ser vacía"

  Escenario: US18-04 Año vacío
    Dado que la cancion tiene por "titulo": "Africa"
    Y que la cancion tiene por "artistas": "Toto"
    Y que la cancion tiene por "duracion": "4:31"
    Y que la cancion tiene "anio" vacio
    Cuando publico en la API con "/canciones" el contenido
    Entonces obtengo el error "El año no puede ser vacio"

  Escenario: US18-05 Duración no numérica
    Dado que la cancion tiene por "titulo": "Africa"
    Y que la cancion tiene por "artistas": "Toto"
    Y que la cancion tiene por "duracion": "Serengeti"
    Y que la cancion tiene por "anio": "2013"
    Cuando publico en la API con "/canciones" el contenido
    Entonces obtengo el error "Formato de duración inválido. Debe ser MM:SS"

  Escenario: US18-06 Año no numérico
    Dado que la cancion tiene por "titulo": "Africa"
    Y que la cancion tiene por "artistas": "Toto"
    Y que la cancion tiene por "duracion": "4:31"
    Y que la cancion tiene por "anio": "Serengeti"
    Cuando publico en la API con "/canciones" el contenido
    Entonces obtengo el error "Formato de año inválido. Debe ser un número menor al año actual"
  @wip
  Escenario: US18-07 Duración inválida: formato
    Dado que la cancion tiene por "titulo": "Africa"
    Y que la cancion tiene por "artistas": "Toto"
    Y que la cancion tiene por "duracion": "33"
    Y que la cancion tiene por "anio": "2013"
    Cuando intento registrar la cancion
    Entonces obtengo el error "Formato de duración inválido. Debe ser MM:SS"
  @wip
  Escenario: US18-08 Duración inválida: segundos inválidos
    Dado que la cancion tiene por "titulo": "Africa"
    Y que la cancion tiene por "artistas": "Toto"
    Y que la cancion tiene por "duracion": "3:91"
    Y que la cancion tiene por "anio": "2013"
    Cuando intento registrar la cancion
    Entonces obtengo el error "Formato de duración inválido. Debe ser MM:SS"
  @wip
  Escenario: US18-09 Año inválido: año en el futuro
    Dado que la cancion tiene por "titulo": "Africa"
    Y que la cancion tiene por "artistas": "Toto"
    Y que la cancion tiene por "duracion": "4:31"
    Y que la cancion tiene por "anio": "2033"
    Cuando intento registrar la cancion
    Entonces obtengo el error "Formato de año inválido. Debe ser un número menor al año actual"
  @wip
  Escenario: US18-10 Canción válida
    Dado que la cancion tiene por "titulo": "Africa"
    Y que la cancion tiene por "artistas": "Toto"
    Y que la cancion tiene por "duracion": "4:31"
    Y que la cancion tiene por "anio": "2013"
    Cuando intento registrar la cancion
    Entonces la canción "Africa" es dada de alta


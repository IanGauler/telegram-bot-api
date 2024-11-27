# language: es
Característica:

  Como miembro del equipo de desarrollo
  quiero una API que me permita dar de alta podcasts válidos en la plataforma
  para tener siempre disponible el catálogo de podcasts actualizado en el bot.

  Antecedentes:
    Dado que el anio actual es "2024"
    Y que no hay podcasts en la plataforma

  Escenario: US20-01 Título vacío
    Dado que el podcast tiene "titulo" vacio
    Y que el podcast tiene por "creador" a "LinusTechTips"
    Y que el podcast tiene por "anio" a "2018"
    Y que el podcast tiene "1" episodio valido
    Cuando publico en la API con "/podcasts" el contenido
    Entonces obtengo el error "El titulo no puede ser vacio"

  Escenario: US20-02 Creador vacío
    Dado que el podcast tiene por "titulo" a "WANShow"
    Y que el podcast tiene "creador" vacio
    Y que el podcast tiene por "anio" a "2018"
    Y que el podcast tiene "1" episodio valido
    Cuando publico en la API con "/podcasts" el contenido
    Entonces obtengo el error "El creador no puede ser vacio"

  Escenario: US20-03 Año vacío
    Dado que el podcast tiene por "titulo" a "WANShow"
    Y que el podcast tiene por "creador" a "LinusTechTips"
    Y que el podcast tiene "anio" vacio
    Y que el podcast tiene "1" episodio valido
    Cuando publico en la API con "/podcasts" el contenido
    Entonces obtengo el error "El año no puede ser vacio"

  Escenario: US20-04 Año no numérico
    Dado que el podcast tiene por "titulo" a "WANShow"
    Y que el podcast tiene por "creador" a "LinusTechTips"
    Y que el podcast tiene por "anio" a "Nvidia"
    Y que el podcast tiene "1" episodio valido
    Cuando publico en la API con "/podcasts" el contenido
    Entonces obtengo el error "Formato de año inválido. Debe ser un número menor al año actual"

  Escenario: US20-05 Año en el futuro
    Dado que el podcast tiene por "titulo" a "WANShow"
    Y que el podcast tiene por "creador" a "LinusTechTips"
    Y que el podcast tiene por "anio" a "2033"
    Y que el podcast tiene "1" episodio valido
    Cuando publico en la API con "/podcasts" el contenido
    Entonces obtengo el error "Formato de año inválido. Debe ser un número menor al año actual"

  Escenario: US20-06 Episodios vacío
    Dado que el podcast tiene por "titulo" a "WANShow"
    Y que el podcast tiene por "creador" a "LinusTechTips"
    Y que el podcast tiene por "anio" a "2023"
    Y que el podcast tiene "0" episodio valido
    Cuando publico en la API con "/podcasts" el contenido
    Entonces obtengo el error "Debe contener al menos 1 episodio"

  Escenario: US20-07 Podcast válido
    Dado que el podcast tiene por "titulo" a "WANShow"
    Y que el podcast tiene por "creador" a "LinusTechTips"
    Y que el podcast tiene por "anio" a "2018"
    Y que el podcast tiene "1" episodio valido
    Cuando publico en la API con "/podcasts" el contenido
    Entonces el podcast "WANShow" es dado de alta

  Escenario: US20-08 Podcast sin titulo
    Dado que el podcast tiene por "creador" a "LinusTechTips"
    Y que el podcast tiene por "anio" a "2018"
    Y que el podcast tiene "1" episodio valido
    Cuando publico en la API con "/podcasts" el contenido
    Entonces obtengo el error "Podcast Inválido."

  Escenario: US20-09 Podcast sin creador
    Dado que el podcast tiene por "titulo" a "WANShow"
    Y que el podcast tiene por "anio" a "2018"
    Y que el podcast tiene "1" episodio valido
    Cuando publico en la API con "/podcasts" el contenido
    Entonces obtengo el error "Podcast Inválido."

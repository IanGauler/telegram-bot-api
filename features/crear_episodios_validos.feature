# language: es
Característica:

Como miembro del equipo de desarrollo
quiero una API que me permita dar de alta podcasts con episodios válidos en la plataforma
para tener siempre disponible el catálogo de episodios de podcasts actualizado en el bot.

Antecedentes:
Dado que quiero agregar un podcast válido con un episodio a la plataforma

Escenario: US19-01 Título vacío
Dado que el episodio tiene "titulo" vacio
Y que el episodio tiene por "participantes" a "Brady Haran"
Y que el episodio tiene por "duracion" a "40:23"
Cuando publico en la API con "/podcasts"
Entonces obtengo el error "Episodio inválido: El título no puede ser vacío"

@wip
Escenario: US19-02 Participantes vacío
Dado que el episodio tiene por "titulo" a "Numberphile"
Y que el episodio tiene "participantes" vacio
Y que el episodio tiene por "duracion" a "40:23"
Cuando publico en la API con "/podcasts"
Entonces obtengo el error "Episodio inválido: Los participantes no puede ser vacío"

@wip
Escenario: US19-03 Duración vacía
Dado que el episodio tiene por "titulo" a "Numberphile"
Y que el episodio tiene por "participantes" a "Brady Haran"
Y que el episodio tiene "duracion" vacio
Cuando publico en la API con "/podcasts"
Entonces obtengo el error "Episodio inválido: La duracion no puede ser vacia"

@wip
Escenario: US19-04 Duración no numérica
Dado que el episodio tiene por "titulo" a "Numberphile"
Y que el episodio tiene por "participantes" a "Brady Haran"
Y que el episodio tiene por "duracion" a "Gauss"
Cuando publico en la API con "/podcasts"
Entonces obtengo el error "Episodio inválido: Formato de duración inválido. Debe ser MM:SS"

@wip
Escenario: US19-05 Duración con formato invalido
Dado que el episodio tiene por "titulo" a "Numberphile"
Y que el episodio tiene por "participantes" a "Brady Haran"
Y que el episodio tiene por "duracion" a "33"
Cuando publico en la API con "/podcasts"
Entonces obtengo el error "Episodio inválido: Formato de duración inválido. Debe ser MM:SS"

@wip
Escenario: US19-06 Duración con segundos inválidos
Dado que el episodio tiene por "titulo" a "Numberphile"
Y que el episodio tiene por "participantes" a "Brady Haran"
Y que el episodio tiene por "duracion" a "3:91"
Cuando publico en la API con "/podcasts"
Entonces obtengo el error "Episodio inválido: Formato de duración inválido. Debe ser MM:SS"

@wip
Escenario: US19-07 Episodio válido
Dado que el episodio tiene por "titulo" a "Numberphile"
Y que el episodio tiene por "participantes" a "Brady Haran"
Y que el episodio tiene por "duracion" a "40:23"
Cuando publico en la API con "/podcasts"
Entonces el podcast es dado de alta

